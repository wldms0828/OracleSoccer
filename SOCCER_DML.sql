-- SOCCER_SQL_001
select count(*) AS ���̺��Ǽ� from tab;
-- SOCCER_SQL_002
select team_name "��ü �౸�� ���" from team
order by team_name desc;
-- SOCCER_SQL_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- NVL2()
select distinct position "������" from player;
-- SOCCER_SQL_004
-- ������(ID: K02)��Ű��
select player_name "�̸�"
FROM player
where team_id = 'K02'
    and position = 'GK'
order by player_name;
-- SOCCER_SQL_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����
select position "������", player_name "�̸�"
FROM player
where team_id = 'K02'
    and height >= 170
    and substr(player_name,0,1) like '��' 
;
-- SUBSTR('ȫ�浿',2,2) �ϸ�
-- �浿�� ��µǴµ�
-- ��2�� ������ġ, ��2�� ���ڼ��� ����
-- �ٸ� Ǯ��(����)
SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND PLAYER_NAME LIKE '��%'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
select player_name ||'����' �̸�,
    NVL2(height, height,'0')||'cm' Ű,
    NVL2(weight, weight,'0')||'kg' ������
FROM player
where team_id like 'K02'
order by height;
-- SOCCER_SQL_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� CM �� KG ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
select player_name ||'����' �̸�,
    NVL2(height, height,'0')||'cm' Ű,
    NVL2(weight, weight,'0')||'kg' ������,
    round(weight/((height/100)*(height/100)),2) BMI������
FROM player
where team_id like 'K02'
order by height desc;
-- SOCCER_SQL_008
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- GK �������� ����
-- ����, ����� ��������
select t.team_name,p.position,p.player_name
from player p, team t
where t.team_id = p.team_id
    and t.team_id in('K02','K10')
    and p.position like 'GK'
order by height, player_name,team_name;
-- ANSI JOIN ���(����)

-- SOCCER_SQL_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������
select 
    p.height|| 'cm' Ű , 
    t.team_name "�� ��", 
    p.player_name �̸�
from team t
    join player p
        on t.team_id like p.team_id
where p.team_id in('K02','K10')
    and p.height between 180 and 183
order by p.height, p.player_name,t.team_name;
-- SOCCER_SQL_010
--  ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
select t.team_name ,p.player_name
from team t
join player p
    on t.team_id like p.team_id
where p.position is null or p.position=''
order by t.team_name, p.player_name;
-- SOCCER_SQL_011
-- ���̸�, ��Ÿ��� �̸� ���
select 
    t.team_name ���� ,
    s.stadium_name ��Ÿ���
from team t
join stadium s
    on t.stadium_id like s.stadium_id
;
-- SOCCER_SQL_011-1
select 
    t.team_name ���� ,
    s.stadium_name ��Ÿ���,
    sc.awayteam_id ������ID , 
    sc.sche_date �����ٳ�¥
from team t
join stadium s
    on t.stadium_id like s.stadium_id
join schedule sc
    on sc.stadium_id like t.stadium_id
where sc.sche_date like '20120317'
order by t.team_name
;
-- SOCCER_SQL_012
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
select
    p.player_name ������,
    p.position ������,
    '����' ||t.team_name ���� ,
    s.stadium_name ��Ÿ���,
    sc.sche_date �����ٳ�¥
from team t
join player p
    on t.team_id like p.team_id
join stadium s
    on t.stadium_id like s.stadium_id
join schedule sc
    on sc.stadium_id like s.stadium_id
where sc.sche_date like '20120317'
    and p.position like 'GK'
    and t.team_name like '��ƿ����'
order by p.player_name;
-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
select 
    s1.stadium_name ��Ÿ���,
    sc. sche_date ��⳯¥,
    sc.hometeam_id Ȩ��,
    sc.awayteam_id ������,
    sc.home_score "Ȩ�� ����",
    sc.away_score "������ ����"
from stadium s1 
    join stadium s2
        on s1.stadium_id like s2.stadium_id
    join schedule sc
        on s1.hometeam_id like sc.hometeam_id
    join team t
        on s1.stadium_id like t.stadium_id
where sc.home_score - sc.away_score >= 3
order by sc. sche_date;
-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
select 
s.stadium_name ��Ÿ���,
sc. sche_date ��⳯¥,
ht.region_name ||' '||ht.team_name Ȩ��,
at.region_name ||' '||at.team_name ������,
sc.home_score "Ȩ�� ����",
sc.away_score "������ ����"
from schedule sc
    join stadium s
        on sc.stadium_id like s.stadium_id
    join team ht
        on sc.hometeam_id like ht.team_id
    join team at
        on sc.awayteam_id like at.team_id
where sc.home_score - sc.away_score >= 3
order by sc. sche_date;
-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
select 
    s.stadium_name,
    s.stadium_id,
    s.seat_count,
    s.hometeam_id,
    t.e_team_name
from stadium s
    left join team t
        on s.hometeam_id like t.team_id
   
order by s.hometeam_id;
-- SOCCER_SQL_016
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- UNION VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02'
UNION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K07'
;
---- OR VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
---- IN VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07')
;

-- SOCCER_SQL_017
-- �Ҽ��� �Ｚ ������� ���� �������
-- ���� �巡�������� �������� ���� ����
---- SUBQUERY VERSION
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN 
    ( (SELECT T.TEAM_ID
       FROM TEAM T
       WHERE T.TEAM_NAME 
        IN('�巡����','�Ｚ�������')))
; 

-- 018
-- ��ȣ�� ������ �Ҽ����� ������, ��ѹ��� �����Դϱ�
select 
    p.player_name ������ ,
    t.team_name ���̸� ,
    p.position ������,
    p.back_no ���ȣ
from player p
    join team t
        on p.team_id like t.team_id
        where p.player_name like '��ȣ��'
;     

-- 019
-- ������Ƽ���� MF ���Ű�� ���Դϱ�? 174.87
select
    round(avg (p.height),2) "������Ƽ��MF���Ű"
from player p
    join team t
        on p.team_id like t.team_id
where p.position like 'MF'
        and t.team_name like '��Ƽ��'
    ;
--�ȳ��ö� �� ����        
--select
--    *
--from player p
--    join team t
--      on p.team_id like t.team_id
--where p.position like 'MF'
--;
   
-- 020
-- 2012�� ���� ������ ���Ͻÿ�
select 
   (select 
   count(*) 
from schedule 
where sche_date like '201201%') "1��",
    (select 
    count(*)     
from schedule 
where sche_date like '201202%') "2��",
(select 
   count(*) 
from schedule 
where sche_date like '201203%') "3��",

(select 
   count(*) 
from schedule 
where sche_date like '201204%') "4��",

(select 
   count(*) 
from schedule 
where sche_date like '201205%') "5��",

(select 
   count(*) 
from schedule 
where sche_date like '201206%') "6��",

(select 
   count(*) 
from schedule 
where sche_date like '201207%') "7��",

(select 
   count(*) 
from schedule 
where sche_date like '201208%') "8��",

(select 
   count(*) 
from schedule 
where sche_date like '201209%') "9��",

(select 
   count(*) 
from schedule 
where sche_date like '201210%') "10��",

(select 
   count(*) 
from schedule 
where sche_date like '201211%') "11��",

(select 
   count(*) 
from schedule 
where sche_date like '201212%') "12��"

from dual;
select*from schedule;

-- 021
-- 2012�� ���� ����� ����(GUBUN IS YES)�� ���Ͻÿ�
-- ����� 1��:20��� �̷�������...
select 
   (select 
   count(*) 
from schedule 
where sche_date like '201201%')||'���' "1��",
    (select 
    count(*)     
from schedule 
where sche_date like '201202%')||'���' "2��",
(select 
   count(*) 
from schedule 
where sche_date like '201203%')||'���' "3��",

(select 
   count(*) 
from schedule 
where sche_date like '201204%')||'���' "4��",

(select 
   count(*) 
from schedule 
where sche_date like '201205%')||'���' "5��",

(select 
   count(*) 
from schedule 
where sche_date like '201206%')||'���' "6��",

(select 
   count(*) 
from schedule 
where sche_date like '201207%')||'���' "7��",

(select 
   count(*) 
from schedule 
where sche_date like '201208%')||'���' "8��",

(select 
   count(*) 
from schedule 
where sche_date like '201209%')||'���' "9��",

(select 
   count(*) 
from schedule 
where sche_date like '201210%')||'���' "10��",

(select 
   count(*) 
from schedule 
where sche_date like '201211%')||'���' "11��",

(select 
   count(*) 
from schedule 
where sche_date like '201212%')||'���' "12��"

from dual

;


-- 022
-- 2012�� 9�� 14�Ͽ� ������ ���� ���� ����Դϱ�
-- Ȩ��: ?   ������: ? �� ���
select 
    ht.team_name Ȩ��,
    at.team_name ������
from schedule sc
    join stadium s
        on sc.stadium_id like s.stadium_id
    join team ht
        on sc.hometeam_id like ht.team_id
    join team at 
        on sc.awayteam_id like at.team_id
 where sc.sche_date like '20120914'
 ;
--023
--GROUP BY ���
--���� ������ ��
-- ������ũ 20��
--select 
--    count(p.player_id) �����ο�,
--        t.team_id �����̵�
--from 
--    team t
--    join player p
--        on t.team_id like p.team_id
--group by 
--    t.team_id
--order by t.team_id
--   ;

select 
    count(p.player_id)||'��' �����ο�,
    (select a.team_name
    from team a
    where
        a.team_id like t.team_id
        )����
from 
    team t
    join player p
        on t.team_id like p.team_id
group by 
    t.team_id
order by t.team_name
;

select 
   count(p.player_id)|| '��' �����ο�,
    (select
    team_name ���̸�
from 
    team
where team_id like t.team_id)  ����
from 
    team t
   join player p
        on t.team_id like p.team_id
group by 
    t.team_id
order by t.team_id
   ;
   
select
    team_name ���̸�
from 
    team
where team_id like 'K02'
;
-- 024 ������ ������ ǥ�� �����̸� '����'���� ǥ��
select
    player_name,
    position,
    case
        when position is null then '����'
        when position like 'GK' then '��Ű��'
        when position like 'MF' then '�̵��ʴ�'
        when position like 'FW' then '���ݼ�'
        when position like 'DF' then '�����'
        else position
    end ������
from
    player
where 
    team_id = 'K08'
;

--��Į�� �ȿ� �� ����
select team_name ����
from teamz
where team_id like 'ateam'
 ;
 
select
    player_name,
    position,
    case
        when position is null then '����'
        when position like 'GK' then '��Ű��'
        when position like 'MF' then '�̵��ʴ�'
        when position like 'FW' then '���ݼ�'
        when position like 'DF' then '�����'
        else position
    end ������
from
    player
where 
    team_id = 'K08'
; 

--025.Ű ������� NO. �ű��(inline view �� ���ؼ�)
--�Ｚ�������� Ű ������ ž10 ���
select
    rownum "No. ",
    A.*
from (SELECT 
        T.TEAM_NAME ����,
        P.PLAYER_NAME ������,
        P.POSITION ������,
        P.BACK_NO ��ѹ�,
        P.HEIGHT Ű
    FROM PLAYER P
        JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID
    WHERE 
    T.TEAM_ID  like (select t.team_id
                    from team t 
                    where t.team_name like '�Ｚ�������')
                        and p.height is not null
                    ORDER BY P.HEIGHT DESC) A 
where rownum <=10
;
--Ű ������� NO. �ű��(inline view �� ���ؼ�)
--�Ｚ�������� Ű ������ 11-20�� ���� ���
select
    B.*
from
(select
    rownum "No. ",
    A.*
from (SELECT 
        T.TEAM_NAME ����,
        P.PLAYER_NAME ������,
        P.POSITION ������,
        P.BACK_NO ��ѹ�,
        P.HEIGHT Ű
    FROM PLAYER P
        JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID
    WHERE 
    T.TEAM_ID  like (select t.team_id
                    from team t 
                    where t.team_name like '�Ｚ�������')
        and p.height is not null
 
        
ORDER BY P.HEIGHT DESC) A ) B
where B."No. " between 11 and 20
;

--���̵� �ƴ� ���¿��� �Ｚ��������� Ű���� ������ܺ���
SELECT 
    T.TEAM_NAME ����,
    P.PLAYER_NAME ������,
    P.POSITION ������,
    P.BACK_NO ��ѹ�,
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID  like (select t.team_id
from team t 
where t.team_name like '�Ｚ�������')
    and P.HEIGHT is not null 
ORDER BY P.HEIGHT DESC
;
--�ζ��κ� ��������
select team_id
from team
where team_name like '�Ｚ�������'
;

-- 026.
-- ���� ��Ű���� ��� Ű����
-- ���� ���Ű�� ū ������
select
    a.tname ����
   from (select   
    (select team_name 
        from team a
        where a.team_id like t.team_id) tname,
    round(avg(p.height),2) ht
    
from team t
    join player p
        on t.team_id like p.team_id
where p.position like 'GK'

group by t.team_id
order by ht desc) a
where rownum = 1
;

select   
    (select team_name 
        from team a
        where a.team_id like t.team_id) tname,
    round(avg(p.height),2) ht
    
from team t
    join player p
        on t.team_id like p.team_id
where p.position like 'GK'

group by t.team_id
order by ht desc;
-- 027.
-- �� ���ܺ� ������ ���Ű�� �Ｚ �����������
-- ���Ű���� ���� ���� �̸��� �ش� ���� ���Ű�� 
-- ���Ͻÿ�
select b.*
from
(select 
    a.tname ����,
    a.hei ���Ű,
    rownum rn
    from  (select 
    round(avg(p.height) ,2) hei,
    (select team_name 
     from team a
     where a.team_id like t.team_id) tname
from team t
    join player p
        on t.team_id like p.team_id

group by t.team_id
order by hei desc) a
)b
where b.rn >7
;  

-- 028.
-- 2012�� ��� �߿��� �������� ���� ū ��� ����
select 
   sc.sche_date �����,
   sc.hometeam_id || Ȩ�� || 'VS' || sc.awayteam_id ||������ 
from stadium s
    join schedule sc
        on s.stadium_id like sc.stadium_id
where sc.home_score - sc.away_score
;
-- 029.
-- �¼������ ��Ÿ��� ���� �ű��
select
     rownum "NO. ",
    A.*
from (select 
    s.stadium_name ��Ÿ���,
    s.seat_count �¼���
    from stadium s
order by s.seat_count desc) A
;

select 
    s.stadium_name ��Ÿ���,
    s.seat_count �¼���
    from stadium s
order by s.seat_count desc;
-- 030.
-- 2012�� ���� �¸� ������ �����ű��

select
    sc.sche_date,
    case
        when sc.home_score > sc.away_score then ht.team_name
        when sc.away_score > sc.away_score then at.team_name
        else '���º�'
        end winner
from schedule sc
    join team ht 
       on sc.hometeam_id like ht.team_id
    join team at
       on sc.awayteam_id like at.team_id
where sc.sche_date like '2012%'
    and sc.gubun like 'Y'
;

select
    a.winner �¸���,
    count(a.winner) �¸�
    
from
    (select
    sc.sche_date,
    case
        when sc.home_score > sc.away_score then ht.team_name
        when sc.away_score > sc.away_score then at.team_name
        else '���º�'
        end winner
from schedule sc
    join team ht 
       on sc.hometeam_id like ht.team_id
    join team at
       on sc.awayteam_id like at.team_id
where sc.sche_date like '2012%'
    and sc.gubun like 'Y')a
    where a.winner not like '���º�'
group by a.winner
order by �¸� desc
;


 select 
    a.winner �¸���,
    count(a.winner) �¸�
    from(select 
        sc.sche_date,
   case 
    when sc.home_score > sc.away_score then ht.team_name
    when sc.away_score > sc.home_score then at.team_name
    else '���º�'
    end winner
from schedule sc 
    join team ht
        on ht.team_id like sc.hometeam_id 
    join team at
        on at.team_id like sc.awayteam_id
where sc.gubun like 'Y'
    and sc.sche_date like '2012%')a
where a.winner not like '���º�'
group by a.winner
order by �¸� desc
;

select * from schedule;
select 
    sc.sche_date,
   case 
    when sc.home_score > sc.away_score then ht.team_name
    when sc.away_score > sc.home_score then at.team_name
    else '���º�'
    end winner
from schedule sc 
    join team ht
        on ht.team_id like sc.hometeam_id 
    join team at
        on at.team_id like sc.awayteam_id
where sc.gubun like 'Y'
    and sc.sche_date like '2012%';
    
    
    ---- sample
    
    select   
         (select team_name 
            from team a
            where a.team_id like t.team_id) tname,
            round(avg(p.height),2) ht
            
            from team t
            join player p
            on t.team_id like p.team_id
            where p.position like 'GK'
            
            group by t.team_id
        ;
    
    