# GLIP Sale (Mainnet)

## 준비
```bash
npm i
cp .env.example .env
# .env 파일에 RPC URL, PRIVATE_KEY, ETHERSCAN_API_KEY 작성
```

## 배포
```bash
GLIP_ADDRESS=0xD0b86b79AE4b8D7bb88b37EBe228ce343D79794e PRICE_PER_GLIP_ETH=0.001 npm run deploy:mainnet
```

배포 성공 시 콘솔에 SALE_ADDRESS 출력됨.

## GLIP 예치
```bash
SALE_ADDRESS=<배포된주소> GLIP_ADDRESS=0xD0b86b79AE4b8D7bb88b37EBe228ce343D79794e FUND_AMOUNT=10000 npm run fund:mainnet
```

## 가격 변경
```bash
SALE_ADDRESS=<배포된주소> NEW_PRICE_ETH=0.002 npm run setprice:mainnet
```
