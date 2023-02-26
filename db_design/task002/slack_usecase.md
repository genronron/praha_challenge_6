# DBモデリング2

- ユースケース&クエリ
    - ワークスペースを作成する
    
    ```sql
    INSERT INTO workspace VALUES (
    UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116') -- id
    ,'usecase55' -- name
    );
    ```
    
    - ワークスペースに参加する
    
    ```sql
    INSERT INTO user VALUES (
    UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- id
    ,UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116') -- workspaceId
    ,'usecaseName' -- name
    );
    ```
    
    - ワークスペースから脱退する
    
    ```sql
    DELETE FROM user
    WHERE
    id = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917')
    AND
    workspaceId = UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116');
    ```
    
    - ワークスペース内のチャンネルを表示する
    
    ```sql
    SELECT * FROM channel
    WHERE workspaceId = UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116');
    ```
    
    - チャンネルを作成する
    
    ```sql
    INSERT INTO channel VALUES(
    UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- id
    ,UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116') -- workspaceId
    , 'usecaseChannel' -- name
    );
    ```
    
    - チャンネルに参加する
    
    ```sql
    INSERT INTO channelMember VALUES (
    UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- channelId
    , UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- userId
    );
    ```
    
    - チャンネルから脱退する
    
    ```sql
    DELETE FROM channelMember
    WHERE channelId = UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915')
    AND
    userId = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917');
    ```
    
    - メッセージを投稿する
    
    ```sql
    INSERT INTO thread VALUES (UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277'));
    INSERT INTO message VALUES (
    UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5') -- id
    ,UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- channelId
    ,UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277') -- threadId
    ,UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- userId
    ,NOW()
    ,'usecaseMessage test');
    ```
    
    - スレッドメッセージを投稿する
    
    ```sql
    -- 紐づくメッセージよりthreadIdを取得する
    SELECT BIN_TO_UUID(threadId) AS threadId From message WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5');
    -- 紐づくメッセージと同じthreadIdで投稿する
    INSERT INTO message VALUES (
    UUID_TO_BIN('11147a36-4bd8-fe5e-f66e-fb263ebbd5f2') -- id
    ,UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- channelId
    ,UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277') -- threadId
    ,UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- userId
    ,NOW()
    ,'usecaseThreadMessage test');
    ```
    
    - メッセージを編集する
    
    ```sql
    UPDATE message set content = 'usecaseMessage edit' WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5') -- id;
    SELECT * FROM message WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5') -- id;
    ```
    
    - メッセージを削除する
    
    ```sql
    -- 紐づくthreadIdを取得する
    SELECT threadId FROM message WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5');
    -- 同じthredIdのレコードを削除する
    DELETE FROM message WHERE threadId = UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277');
    SELECT * FROM message WHERE threadId = UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277');
    ```
    
    - スレッドメッセージを編集する
    
    ```sql
    UPDATE message set content = 'usecaseThreadMessage edit' WHERE id = UUID_TO_BIN('11147a36-4bd8-fe5e-f66e-fb263ebbd5f2');
    ```
    
    - スレッドメッセージを削除する
    
    ```sql
    DELETE From message WHERE id = UUID_TO_BIN('11147a36-4bd8-fe5e-f66e-fb263ebbd5f2');
    ```
    
    - チャンネル内のメッセージの表示
    
    ```sql
    SELECT 
     BIN_TO_UUID(ms.id) AS id
    ,BIN_TO_UUID(ms.channelId) AS channelId
    ,BIN_TO_UUID(ms.threadId) AS threadId
    ,BIN_TO_UUID(ms.userId) AS userId
    ,createDate
    ,content
    FROM
    	channelMember AS cm	
    	INNER JOIN
      message AS ms
    	ON cm.channelId = ms.channelId
    WHERE
    	cm.userId = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917')
    ORDER BY
    	createDate;
    ```
    
    - 横断機能
    
    ```sql
    
    SELECT 
     BIN_TO_UUID(ms.id) AS id
    ,BIN_TO_UUID(ms.channelId) AS channelId
    ,BIN_TO_UUID(ms.threadId) AS threadId
    ,BIN_TO_UUID(ms.userId) AS userId
    ,createDate
    ,content
    FROM
    	(SELECT * FROM channelMember WHERE userId = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917')) AS cm	
    	INNER JOIN
      (SELECT * FROM message WHERE userId = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917')) AS ms
    	ON cm.channelId = ms.channelId
    WHERE
    /* 	cm.userId = 55
      AND */
    	ms.content LIKE '%message%'
    ORDER BY
    	createDate
    ```- ユースケース&クエリ
    - ワークスペースを作成する
    
    ```sql
    INSERT INTO workspace VALUES (
    UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116') -- id
    ,'usecase55' -- name
    );
    ```
    
    - ワークスペースに参加する
    
    ```sql
    INSERT INTO user VALUES (
    UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- id
    ,UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116') -- workspaceId
    ,'usecaseName' -- name
    );
    ```
    
    - ワークスペースから脱退する
    
    ```sql
    DELETE FROM user
    WHERE
    id = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917')
    AND
    workspaceId = UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116');
    ```
    
    - ワークスペース内のチャンネルを表示する
    
    ```sql
    SELECT * FROM channel
    WHERE workspaceId = UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116');
    ```
    
    - チャンネルを作成する
    
    ```sql
    INSERT INTO channel VALUES(
    UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- id
    ,UUID_TO_BIN('727f0bb2-5cbb-1742-4695-e23ae786e116') -- workspaceId
    , 'usecaseChannel' -- name
    );
    ```
    
    - チャンネルに参加する
    
    ```sql
    INSERT INTO channelMember VALUES (
    UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- channelId
    , UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- userId
    );
    ```
    
    - チャンネルから脱退する
    
    ```sql
    DELETE FROM channelMember
    WHERE channelId = UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915')
    AND
    userId = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917');
    ```
    
    - メッセージを投稿する
    
    ```sql
    INSERT INTO thread VALUES (UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277'));
    INSERT INTO message VALUES (
    UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5') -- id
    ,UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- channelId
    ,UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277') -- threadId
    ,UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- userId
    ,NOW()
    ,'usecaseMessage test');
    ```
    
    - スレッドメッセージを投稿する
    
    ```sql
    -- 紐づくメッセージよりthreadIdを取得する
    SELECT BIN_TO_UUID(threadId) AS threadId From message WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5');
    -- 紐づくメッセージと同じthreadIdで投稿する
    INSERT INTO message VALUES (
    UUID_TO_BIN('11147a36-4bd8-fe5e-f66e-fb263ebbd5f2') -- id
    ,UUID_TO_BIN('ad3ba4c8-eb1d-aea5-ab57-da2fea584915') -- channelId
    ,UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277') -- threadId
    ,UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917') -- userId
    ,NOW()
    ,'usecaseThreadMessage test');
    ```
    
    - メッセージを編集する
    
    ```sql
    UPDATE message set content = 'usecaseMessage edit' WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5') -- id;
    SELECT * FROM message WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5') -- id;
    ```
    
    - メッセージを削除する
    
    ```sql
    -- 紐づくthreadIdを取得する
    SELECT threadId FROM message WHERE id = UUID_TO_BIN('3c689e2a-a9c9-f138-7d34-7b08fbcd11c5');
    -- 同じthredIdのレコードを削除する
    DELETE FROM message WHERE threadId = UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277');
    SELECT * FROM message WHERE threadId = UUID_TO_BIN('9458f643-90c9-22fe-750c-9fd12361c277');
    ```
    
    - スレッドメッセージを編集する
    
    ```sql
    UPDATE message set content = 'usecaseThreadMessage edit' WHERE id = UUID_TO_BIN('11147a36-4bd8-fe5e-f66e-fb263ebbd5f2');
    ```
    
    - スレッドメッセージを削除する
    
    ```sql
    DELETE From message WHERE id = UUID_TO_BIN('11147a36-4bd8-fe5e-f66e-fb263ebbd5f2');
    ```
    
    - チャンネル内のメッセージの表示
    
    ```sql
    SELECT 
     BIN_TO_UUID(ms.id) AS id
    ,BIN_TO_UUID(ms.channelId) AS channelId
    ,BIN_TO_UUID(ms.threadId) AS threadId
    ,BIN_TO_UUID(ms.userId) AS userId
    ,createDate
    ,content
    FROM
    	channelMember AS cm	
    	INNER JOIN
      message AS ms
    	ON cm.channelId = ms.channelId
    WHERE
    	cm.userId = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917')
    ORDER BY
    	createDate;
    ```
    
    - 横断機能
    
    ```sql
    
    SELECT 
     BIN_TO_UUID(ms.id) AS id
    ,BIN_TO_UUID(ms.channelId) AS channelId
    ,BIN_TO_UUID(ms.threadId) AS threadId
    ,BIN_TO_UUID(ms.userId) AS userId
    ,createDate
    ,content
    FROM
    	(SELECT * FROM channelMember WHERE userId = UUID_TO_BIN('27ec302c-63d3-5602-5402-53eac3829917')) AS cm	
    	INNER JOIN
      message AS ms
    	ON cm.channelId = ms.channelId
    WHERE
    /* 	cm.userId = 55
      AND */
    	ms.content LIKE '%message%'
    ORDER BY
    	createDate
    ```