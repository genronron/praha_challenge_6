- リマインダーステータスの事前登録
    
    ```sql
    INSERT INTO reminderStatus VALUES(1, '未完了');
    INSERT INTO reminderStatus VALUES(2, '完了');
    INSERT INTO reminderStatus VALUES(3, '送信済');
    INSERT INTO reminderStatus VALUES(9, '破棄');
    ```
    
- リマインダーとリマインダー宛先の作成　（毎日）
    
    ```sql
    -- 毎日
    INSERT INTO reminder VALUES(
    UUID_TO_BIN('12817ea0-cf1b-03d9-5394-305a2c4fb8e8') -- id
    ,CURDATE() -- createDate
    ,CURDATE() -- startDate
    ,'reminder.javaのレビューNO.190の修正' -- content
    ,'毎日'-- remindertype
    ,1 -- statusId
    );
    
    INSERT INTO reminderDestinationUser VALUES(
    UUID_TO_BIN('12817ea0-cf1b-03d9-5394-305a2c4fb8e8') -- reminderid
    ,UUID_TO_BIN('ece66b48-6b49-5367-450b-09364cf2c4dd') -- userid
    );
    ```
    
- リマインダーとリマインダー宛先の作成　（3日おき）
    
    ```sql
    -- 3日おき
    INSERT INTO reminder VALUES(
    UUID_TO_BIN('9978b0c8-7840-b16a-411d-43cee90e6a2e') -- id
    ,CURDATE() -- createDate
    ,CURDATE() -- startDate
    ,'個人フォルダの整理' -- content
    ,'3日おき'-- remindertype
    ,1 -- statusId
    );
    
    INSERT INTO reminderDestinationUser VALUES(
    UUID_TO_BIN('9978b0c8-7840-b16a-411d-43cee90e6a2e') -- reminderid
    ,UUID_TO_BIN('9078345c-24b4-6aff-5837-16bbf5a11b55') -- userid
    );
    ```
    
- リマインダーとリマインダー宛先の作成　（毎週金曜日）
    
    ```sql
    -- 毎週金曜日
    INSERT INTO reminder VALUES(
    UUID_TO_BIN('fcff1d6c-1b71-876f-9d70-9d7addd0e394') -- id
    ,CURDATE() -- createDate
    ,CURDATE() -- startDate
    ,'ソースコードのリファクタリング' -- content
    ,'毎週金曜日'-- remindertype
    ,1 -- statusId
    );
    
    INSERT INTO reminderDestinationUser VALUES(
    UUID_TO_BIN('fcff1d6c-1b71-876f-9d70-9d7addd0e394') -- reminderid
    ,UUID_TO_BIN('070744f1-dc13-14e0-281f-be51d9697823') -- userid
    );
    
    -- startDateを直近曜日日付に更新する
    UPDATE
        reminder
    SET
        
    ```
    
- リマインダーとリマインダー宛先の作成　（毎月15日）
    
    ```sql
    -- 毎月15日
    INSERT INTO reminder VALUES(
    UUID_TO_BIN('60bc79f8-e143-2755-03ef-df079ef6848f') -- id
    ,CURDATE() -- createDate
    ,CURDATE() -- startDate
    ,'翌月の勤務時間スケジュールの入力' -- content
    ,'毎月15日'-- remindertype
    ,1 -- statusId
    );
    
    INSERT INTO reminderDestinationUser VALUES(
    UUID_TO_BIN('60bc79f8-e143-2755-03ef-df079ef6848f') -- reminderid
    ,UUID_TO_BIN('ece66b48-6b49-5367-450b-09364cf2c4dd') -- userid
    );
    
    INSERT INTO reminderDestinationUser VALUES(
    UUID_TO_BIN('60bc79f8-e143-2755-03ef-df079ef6848f') -- reminderid
    ,UUID_TO_BIN('9078345c-24b4-6aff-5837-16bbf5a11b55') -- userid
    );
    
    INSERT INTO reminderDestinationUser VALUES(
    UUID_TO_BIN('60bc79f8-e143-2755-03ef-df079ef6848f') -- reminderid
    ,UUID_TO_BIN('070744f1-dc13-14e0-281f-be51d9697823') -- userid
    );
    ```
    
- リマインダーの配信(1時間おき)
    
    ```sql
    -- 作成日からの経過日数がリマインダーサイクルの倍数日付になっている」レコードをSELECTする。
    SELECT
        BIN_TO_UUID(rm.id)
       ,rm.createDate
       ,rm.startDate
       ,rm.content
       ,rm.remindertype
    FROM
        reminder AS rm
    WHERE
        statusId = 1 -- 未完了
        AND CASE
              WHEN remindertype = '毎日'
                THEN true
              WHEN remindertype LIKE '%日おき'
                THEN DATEDIFF(CURDATE(), createDate) / CONVERT(REGEXP_REPLACE(remindertype, '日おき', ''), UNSIGNED) = 1
              WHEN remindertype LIKE '%曜日'
                THEN DATEDIFF(CURDATE(), startDate) / 7 = 1
              WHEN remindertype LIKE '毎月%' -- 存在しない日付は入ってこない。
                THEN DAYOFMONTH(CURDATE()) = CONVERT(REGEXP_REPLACE(REGEXP_REPLACE(remindertype, '毎月', ''), '日', ''), UNSIGNED)
            END;
    ```
