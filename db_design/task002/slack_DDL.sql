CREATE TABLE `message` (
  `id` int PRIMARY KEY NOT NULL,
  `channelId` int NOT NULL,
  `threadId` int NOT NULL,
  `userId` int NOT NULL,
  `createDate` datetime NOT NULL,
  `content` nvarchar(4000) NOT NULL
);

CREATE TABLE `thread` (
  `id` int PRIMARY KEY NOT NULL
);

CREATE TABLE `user` (
  `id` int PRIMARY KEY NOT NULL,
  `workspaceId` int NOT NULL,
  `name` nvarchar(50) NOT NULL
);

CREATE TABLE `channel` (
  `id` int PRIMARY KEY NOT NULL,
  `workspaceId` int NOT NULL,
  `name` nvarchar(200) NOT NULL
);

CREATE TABLE `workspace` (
  `id` int PRIMARY KEY NOT NULL,
  `name` nvarchar(200) NOT NULL
);

CREATE TABLE `channelMember` (
  `channelId` int UNIQUE NOT NULL,
  `userId` int UNIQUE NOT NULL
);

ALTER TABLE `message` ADD FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`);

ALTER TABLE `message` ADD FOREIGN KEY (`threadId`) REFERENCES `thread` (`id`);

ALTER TABLE `message` ADD FOREIGN KEY (`userId`) REFERENCES `user` (`id`);

ALTER TABLE `user` ADD FOREIGN KEY (`workspaceId`) REFERENCES `workspace` (`id`);

ALTER TABLE `channel` ADD FOREIGN KEY (`workspaceId`) REFERENCES `workspace` (`id`);

ALTER TABLE `channelMember` ADD FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`);

ALTER TABLE `channelMember` ADD FOREIGN KEY (`userId`) REFERENCES `user` (`id`);
