/* eslint-disable max-len */
/* eslint-disable no-bitwise */
// const { BrowserQRCodeReader } = require('@zxing/browser');

// const codeReader = new BrowserQRCodeReader();
const base64 = document.getElementById('reader').src;
// const resultImage = codeReader.decodeFromImageElement(url);
const {
  MultiFormatReader,
  BarcodeFormat,
  DecodeHintType,
  RGBLuminanceSource,
  BinaryBitmap,
  HybridBinarizer,
} = require('@zxing/library');

const { PNG } = require('pngjs');

const rawImageData = PNG.sync.read(Buffer.from(base64.split(';base64,')[1], 'base64'));

const hints = new Map();
const formats = [BarcodeFormat.QR_CODE, BarcodeFormat.DATA_MATRIX];

hints.set(DecodeHintType.POSSIBLE_FORMATS, formats);
hints.set(DecodeHintType.TRY_HARDER, true);

const reader = new MultiFormatReader();

reader.setHints(hints);

const len = rawImageData.width * rawImageData.height;

const luminancesUint8Array = new Uint8ClampedArray(len);
for (let i = 0; i < len; i += 1) {
  luminancesUint8Array[i] = ((rawImageData.data[i * 4] + rawImageData.data[i * 4 + 1] * 2 + rawImageData.data[i * 4 + 2]) / 4) & 0xFF;
}

const luminanceSource = new RGBLuminanceSource(luminancesUint8Array, rawImageData.width, rawImageData.height);

const binaryBitmap = new BinaryBitmap(new HybridBinarizer(luminanceSource));

const qrCode = reader.decode(binaryBitmap);

if (qrCode) {
  return qrCode.getText();
}
return '';
