# DBモデリング2

- ユースケース&クエリ
    - ワークスペースを作成する
    
    ```sql
    INSERT INTO workspace VALUES (55, 'usecase55');
    ```
    
    - ワークスペースに参加する
    
    ```sql
    INSERT INTO user VALUES (55, 55, 'usecaseName');
    ```
    
    - ワークスペースから脱退する
    
    ```sql
    DELETE FROM user WHERE id = 55 AND workspaceId = 55;
    ```
    
    - ワークスペース内のチャンネルを表示する
    
    ```sql
    SELECT * FROM channel WHERE workspaceId = 55;
    ```
    
    - チャンネルを作成する
    
    ```sql
    INSERT INTO channel VALUES(55, 55, 'usecaseChannel');
    ```
    
    - チャンネルに参加する
    
    ```sql
    INSERT INTO channelMember VALUES (55, 55);
    ```
    
    - チャンネルから脱退する
    
    ```sql
    DELETE FROM channelMember WHERE channelId = 55 AND userId = 55;
    ```
    
    - メッセージを投稿する
    
    ```sql
    -- SELECT MAX(id) + 1 FROM thread;
    INSERT INTO thread VALUES (55);
    INSERT INTO message VALUES (55,55,55,55,NOW(),'usecaseMessage test');
    ```
    
    - スレッドメッセージを投稿する
    
    ```sql
    -- 紐づくメッセージよりthreadIdを取得する
    SELECT threadId From message WHERE id = 55;
    -- 紐づくメッセージと同じthreadIdで投稿する
    INSERT INTO message VALUES (56,55,55,55,NOW(),'usecaseThreadMessage test');
    ```
    
    - メッセージを編集する
    
    ```sql
    UPDATE message set content = 'usecaseMessage edit' WHERE id = 55;
    SELECT * FROM message WHERE id = 55;
    ```
    
    - メッセージを削除する
    
    ```sql
    -- 紐づくthreadIdを取得する
    SELECT threadId FROM message WHERE id = 55;
    -- 同じthredIdのレコードを削除する
    DELETE FROM message WHERE threadId = 55;
    SELECT * FROM message WHERE threadId = 55;
    ```
    
    - スレッドメッセージを編集する
    
    ```sql
    UPDATE message set content = 'usecaseThreadMessage edit' WHERE id = 56;
    ```
    
    - スレッドメッセージを削除する
    
    ```sql
    DELETE From message WHERE id = 56;
    ```
    
    - チャンネル内のメッセージの表示
    
    ```sql
    SELECT 
    	ms.*
    FROM
    	channelMember AS cm	
    	INNER JOIN
      message AS ms
    	ON cm.channelId = ms.channelId
    WHERE
    	cm.userId = 55
    ORDER BY
    	createDate;
    ```
    
    - 横断機能
    
    ```sql
    SELECT 
    	ms.*
    FROM
    	channelMember AS cm	
    	INNER JOIN
      message AS ms
    	ON cm.channelId = ms.channelId
    WHERE
    	cm.userId = 55
      AND
    	ms.content LIKE '%message%'
    ORDER BY
    	createDate;
    ```