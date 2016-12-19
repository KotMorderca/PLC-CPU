#include <stdio.h>
#include <string.h>
#include "platform.h"
#include "xparameters.h"
#include "xilisf.h"
#include "xgpio.h"

void print(char *str);

int sleep(int ticks) {
	int i = 0, k = 0;
	for (i = 0; i < ticks; i++) {
		k++;
	}
	return k;
}
#if 0
static XGpio gpio;

int main() {
	init_platform();
	XGpio_Initialize(&gpio, XPAR_AXI_GPIO_0_DEVICE_ID);

	uint64_t data[] = {0x0000000001, 0x1F000000E0, 0x2800000000, 0x4300000000,
		0x210000000B, 0x4300000001, 0x210000000F, 0x4300000002,
		0x2100000015, 0x4300000003, 0x210000001B, 0x2800000060,
		0x4300000001, 0x2100000024, 0x2000000021, 0x2800000060,
		0x4300000003, 0x2100000027, 0x4300000001, 0x2100000024,
		0x2000000021, 0x2800000060, 0x4300000007, 0x210000002A,
		0x4300000003, 0x2100000027, 0x2000000021, 0x0000000001,
		0x1E000000E0, 0x2800000060, 0x4300000007, 0x210000002A,
		0x2000000021, 0x2700000000, 0x4100000000, 0x200000002C,
		0x2700000001, 0x4100000000, 0x200000002C, 0x2700000002,
		0x4100000000, 0x200000002C, 0x2700000003, 0x4100000000,
		0x2600000000, 0xFF00000000};
	uint8_t len = sizeof(data) / sizeof(data[0]), i = 0;

	for (i = 0; i < len; i++) {
		XGpio_DiscreteWrite(&gpio, 2, 0);
		XGpio_DiscreteWrite(&gpio, 1, 0);
		sleep(10000);
		XGpio_DiscreteWrite(&gpio, 1, (uint32_t) data[i] & 0xFFFFFFFF);
		XGpio_DiscreteWrite(&gpio, 2,
				0x4000 | ((i & 0x3F) << 8) | ((data[i] >> 32) & 0xFF));
		sleep(100000);
	}

	XGpio_DiscreteWrite(&gpio, 2, 0x8000);
	XGpio_DiscreteWrite(&gpio, 1, 0);
	print("Programming complete!");
	while (1) {

	}

	cleanup_platform();
	return 0;
}
#else

#define ISF_PAGE_SIZE		256
#define ISF_TEST_ADDRESS	0x400000;

static int IsfWaitForFlashNotBusy(void);
static XIsf Isf;
static XSpi Spi;
u8 IsfWriteBuffer[ISF_PAGE_SIZE + XISF_CMD_SEND_EXTRA_BYTES];
u8 ReadBuffer[ISF_PAGE_SIZE + XISF_CMD_SEND_EXTRA_BYTES];
u64 data[8];

int main() {
	int Status, i, prog_len, k = 1, addr = 0;
	XIsf_ReadParam ReadParam;
	XGpio gpio;
	XGpio_Initialize(&gpio, XPAR_AXI_GPIO_0_BASEADDR);
	Status = XSpi_Initialize(&Spi, XPAR_SPI_0_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XSpi_Start(&Spi);
	XSpi_IntrGlobalDisable(&Spi);
	Status = XIsf_Initialize(&Isf, &Spi, 0x01, IsfWriteBuffer);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	ReadParam.Address = 0x600000;
	ReadParam.NumBytes = ISF_PAGE_SIZE;
	ReadParam.ReadPtr = ReadBuffer;
	Status = XIsf_Read(&Isf, XISF_READ, (void*) &ReadParam);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	memcpy(data, ReadBuffer + XISF_CMD_SEND_EXTRA_BYTES, (size_t) 256);
	prog_len = data[0];
	for (i = 1; i < 8; i++) {
		XGpio_DiscreteWrite(&gpio, 2, 0);
		XGpio_DiscreteWrite(&gpio, 1, 0);
		sleep(10000);
		XGpio_DiscreteWrite(&gpio, 1, (uint32_t) data[i] & 0xFFFFFFFF);
		XGpio_DiscreteWrite(&gpio, 2,
				0x4000 | ((addr & 0x3F) << 8) | ((data[i] >> 32) & 0xFF));
		sleep(10000);
		addr++;
	}
	prog_len -= 7;

	while (prog_len > 0) {
		ReadParam.Address = 0x600000 + (k * 64);
		ReadParam.NumBytes = ISF_PAGE_SIZE;
		ReadParam.ReadPtr = ReadBuffer;
		Status = XIsf_Read(&Isf, XISF_READ, (void*) &ReadParam);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}
		memcpy(data, ReadBuffer + XISF_CMD_SEND_EXTRA_BYTES, (size_t) 256);
		for (i = 0; i < ((prog_len > 8) ? 8 : prog_len); i++) {
			XGpio_DiscreteWrite(&gpio, 2, 0);
			XGpio_DiscreteWrite(&gpio, 1, 0);
			sleep(10000);
			XGpio_DiscreteWrite(&gpio, 1, (uint32_t) data[i] & 0xFFFFFFFF);
			XGpio_DiscreteWrite(&gpio, 2,
					0x4000 | ((addr & 0x3F) << 8) | ((data[i] >> 32) & 0xFF));
			sleep(10000);
			addr++;
		}
		prog_len -= 7;
		k++;
	}

	XGpio_DiscreteWrite(&gpio, 2, 0x8000);
	XGpio_DiscreteWrite(&gpio, 1, 0);
	print("Programming complete!");
	while (1) {

	}

	cleanup_platform();
	return 0;
}

int IsfWaitForFlashNotBusy(void) {
	int Status;
	u8 StatusReg;

	while (1) {
		Status = XIsf_GetStatus(&Isf, ReadBuffer);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}
		StatusReg = ReadBuffer[BYTE2];
		if ((StatusReg & XISF_SR_IS_READY_MASK) == 0) {
			if (StatusReg & (0x60)) {
				return XST_FAILURE;
			}
			break;
		}
	}
	return XST_SUCCESS;
}

#endif
