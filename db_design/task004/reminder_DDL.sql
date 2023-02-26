CREATE TABLE `reminder` (
  `id` binary(16) PRIMARY KEY NOT NULL,
  `createDate` datetime NOT NULL,
  `startDate` datetime NOT NULL,
  `content` nvarchar(1000) NOT NULL,
  `remindertype` nvarchar(200) NOT NULL,
  `statusId` tinyint NOT NULL
);

CREATE TABLE `reminderStatus` (
  `id` tinyint PRIMARY KEY NOT NULL,
  `explain` nvarchar(30) NOT NULL
);

CREATE TABLE `reminderDestinationUser` (
  `reminderId` binary(16) NOT NULL,
  `UserId` binary(16) NOT NULL
);

CREATE TABLE `user` (
  `id` binary(16) PRIMARY KEY NOT NULL,
  `name` nvarchar(200) NOT NULL
);

ALTER TABLE `reminderStatus` ADD FOREIGN KEY (`id`) REFERENCES `reminder` (`statusId`);

ALTER TABLE `reminderDestinationUser` ADD FOREIGN KEY (`reminderId`) REFERENCES `reminder` (`id`);

ALTER TABLE `reminderDestinationUser` ADD FOREIGN KEY (`UserId`) REFERENCES `user` (`id`);

ALTER TABLE `reminderDestinationUser` ADD UNIQUE `reminderDestinationUserUnique` (`reminderId`, `userId`);
