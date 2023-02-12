CREATE TABLE `message` (
  `id` binary(16) PRIMARY KEY NOT NULL,
  `channelId` binary(16) NOT NULL,
  `threadId` binary(16) NOT NULL,
  `userId` binary(16) NOT NULL,
  `createDate` datetime NOT NULL,
  `content` nvarchar(4000) NOT NULL
);

CREATE TABLE `thread` (
  `id` binary(16) PRIMARY KEY NOT NULL
);

CREATE TABLE `user` (
  `id` binary(16) PRIMARY KEY NOT NULL,
  `workspaceId` binary(16) NOT NULL,
  `name` nvarchar(50) NOT NULL
);

CREATE TABLE `channel` (
  `id` binary(16) PRIMARY KEY NOT NULL,
  `workspaceId` binary(16) NOT NULL,
  `name` nvarchar(200) NOT NULL
);

CREATE TABLE `workspace` (
  `id` binary(16) PRIMARY KEY NOT NULL,
  `name` nvarchar(200) NOT NULL
);

CREATE TABLE `channelMember` (
  `channelId` binary(16) UNIQUE NOT NULL,
  `userId` binary(16) UNIQUE NOT NULL
);

ALTER TABLE `message` ADD FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`);

ALTER TABLE `message` ADD FOREIGN KEY (`threadId`) REFERENCES `thread` (`id`);

ALTER TABLE `message` ADD FOREIGN KEY (`userId`) REFERENCES `user` (`id`);

ALTER TABLE `user` ADD FOREIGN KEY (`workspaceId`) REFERENCES `workspace` (`id`);

ALTER TABLE `channel` ADD FOREIGN KEY (`workspaceId`) REFERENCES `workspace` (`id`);

ALTER TABLE `channelMember` ADD FOREIGN KEY (`channelId`) REFERENCES `channel` (`id`);

ALTER TABLE `channelMember` ADD FOREIGN KEY (`userId`) REFERENCES `user` (`id`);
