// extract-standard-input.js
// 사용법: run-extract.bat 또는 `node extract-standard-input.js`
// 지정된 build-info.json에서 input을 추출해 etherscan-standard-input.json 생성

const fs = require("fs");
const path = require("path");

// ▶ build-info.json 절대 경로 (요청하신 경로로 하드코딩)
const buildInfoPath = "C:\\Users\\1004\\Desktop\\GLIP\\거래소\\glip-sale-hardhat-mainnet\\artifacts\\build-info\\e1f91a6c959563ee74212f4626d9a176.json";

if (!fs.existsSync(buildInfoPath)) {
  console.error("❌ build-info.json 파일이 없습니다:", buildInfoPath);
  process.exit(1);
}

const raw = fs.readFileSync(buildInfoPath, "utf8");
const buildInfo = JSON.parse(raw);

// 참고용 로그
console.log("solcLongVersion:", buildInfo.solcLongVersion);
console.log("optimizer:", buildInfo.input?.settings?.optimizer);
console.log("viaIR:", buildInfo.input?.settings?.viaIR);
console.log("evmVersion:", buildInfo.input?.settings?.evmVersion);

// Etherscan Standard JSON-Input (그대로 업로드)
const out = buildInfo.input;

const outPath = path.join(process.cwd(), "etherscan-standard-input.json");
fs.writeFileSync(outPath, JSON.stringify(out, null, 2), "utf8");

console.log("\n✅ 생성 완료:", outPath);
console.log("   이 파일을 Etherscan Verify & Publish 화면에 업로드하세요.");
