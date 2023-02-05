CREATE TABLE `order` (
  `id` varchar(12) PRIMARY KEY,
  `ordererId` int NOT NULL,
  `isPayed` boolean NOT NULL
);

CREATE TABLE `orderDetail` (
  `orderId` varchar(12) NOT NULL,
  `productId` int NOT NULL,
  `productCount` int NOT NULL,
  `isWasabi` boolean NOT NULL,
  `sushiRiceSizeId` int NOT NULL,
  `sushiRiceTypeId` int NOT NULL
);

CREATE TABLE `product` (
  `id` int PRIMARY KEY,
  `name` varchar(100) UNIQUE NOT NULL,
  `price` decimal(5,0) NOT NULL,
  `productTypeId` int NOT NULL
);

CREATE TABLE `orderer` (
  `id` int PRIMARY KEY,
  `name` varchar(100) NOT NULL,
  `phoneNumber` varchar(13)
);

CREATE TABLE `sushiRiceSize` (
  `id` int PRIMARY KEY,
  `name` varchar(30) UNIQUE NOT NULL
);

CREATE TABLE `sushiRiceType` (
  `id` int PRIMARY KEY,
  `name` varchar(30) UNIQUE NOT NULL
);

CREATE TABLE `productType` (
  `id` int PRIMARY KEY,
  `name` varchar(30) UNIQUE NOT NULL
);

ALTER TABLE `orderDetail` ADD FOREIGN KEY (`orderId`) REFERENCES `order` (`id`);

ALTER TABLE `orderDetail` ADD FOREIGN KEY (`productId`) REFERENCES `product` (`id`);

ALTER TABLE `order` ADD FOREIGN KEY (`ordererId`) REFERENCES `orderer` (`id`);

ALTER TABLE `orderDetail` ADD FOREIGN KEY (`sushiRiceSizeId`) REFERENCES `sushiRiceSize` (`id`);

ALTER TABLE `orderDetail` ADD FOREIGN KEY (`sushiRiceTypeId`) REFERENCES `sushiRiceType` (`id`);

ALTER TABLE `product` ADD FOREIGN KEY (`productTypeId`) REFERENCES `productType` (`id`);
