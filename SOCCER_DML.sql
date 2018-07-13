-- SOCCER_SQL_001
select count(*) AS 테이블의수 from tab;
-- SOCCER_SQL_002
select team_name "전체 축구팀 목록" from team
order by team_name desc;
-- SOCCER_SQL_003
-- 포지션 종류(중복제거,없으면 신입으로 기재)
-- NVL2()
select distinct position "포지션" from player;
-- SOCCER_SQL_004
-- 수원팀(ID: K02)골키퍼
select player_name "이름"
FROM player
where team_id = 'K02'
    and position = 'GK'
order by player_name;
-- SOCCER_SQL_005
-- 수원팀(ID: K02)키가 170 이상 선수
-- 이면서 성이 고씨인 선수
select position "포지션", player_name "이름"
FROM player
where team_id = 'K02'
    and height >= 170
    and substr(player_name,0,1) like '고' 
;
-- SUBSTR('홍길동',2,2) 하면
-- 길동이 출력되는데
-- 앞2는 시작위치, 뒤2는 글자수를 뜻함
-- 다른 풀이(권장)
SELECT POSITION 포지션,PLAYER_NAME 이름
FROM PLAYER
WHERE HEIGHT >= 170
    AND TEAM_ID LIKE 'K02'
    AND PLAYER_NAME LIKE '고%'
ORDER BY PLAYER_NAME 
;
-- SOCCER_SQL_006
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- 키 내림차순
select player_name ||'선수' 이름,
    NVL2(height, height,'0')||'cm' 키,
    NVL2(weight, weight,'0')||'kg' 몸무게
FROM player
where team_id like 'K02'
order by height;
-- SOCCER_SQL_007
-- 수원팀(ID: K02) 선수들 이름,
-- 키와 몸무게 리스트 (단위 CM 와 KG 삽입)
-- 키와 몸무게가 없으면 "0" 표시
-- BMI지수 
-- 키 내림차순
select player_name ||'선수' 이름,
    NVL2(height, height,'0')||'cm' 키,
    NVL2(weight, weight,'0')||'kg' 몸무게,
    round(weight/((height/100)*(height/100)),2) BMI비만지수
FROM player
where team_id like 'K02'
order by height desc;
-- SOCCER_SQL_008
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- GK 포지션인 선수
-- 팀명, 사람명 오름차순
select t.team_name,p.position,p.player_name
from player p, team t
where t.team_id = p.team_id
    and t.team_id in('K02','K10')
    and p.position like 'GK'
order by height, player_name,team_name;
-- ANSI JOIN 사용(권장)

-- SOCCER_SQL_009
-- 수원팀(ID: K02) 과 대전팀(ID: K10)선수들 중 이
-- 키가 180 이상 183 이하인 선수들
-- 키, 팀명, 사람명 오름차순
select 
    p.height|| 'cm' 키 , 
    t.team_name "팀 명", 
    p.player_name 이름
from team t
    join player p
        on t.team_id like p.team_id
where p.team_id in('K02','K10')
    and p.height between 180 and 183
order by p.height, p.player_name,t.team_name;
-- SOCCER_SQL_010
--  모든 선수들 중
-- 포지션을 배정받지 못한 선수들의 팀과 이름
-- 팀명, 사람명 오름차순
select t.team_name ,p.player_name
from team t
join player p
    on t.team_id like p.team_id
where p.position is null or p.position=''
order by t.team_name, p.player_name;
-- SOCCER_SQL_011
-- 팀이름, 스타디움 이름 출력
select 
    t.team_name 팀명 ,
    s.stadium_name 스타디움
from team t
join stadium s
    on t.stadium_id like s.stadium_id
;
-- SOCCER_SQL_011-1
select 
    t.team_name 팀명 ,
    s.stadium_name 스타디움,
    sc.awayteam_id 원정팀ID , 
    sc.sche_date 스케줄날짜
from team t
join stadium s
    on t.stadium_id like s.stadium_id
join schedule sc
    on sc.stadium_id like t.stadium_id
where sc.sche_date like '20120317'
order by t.team_name
;
-- SOCCER_SQL_012
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
select
    p.player_name 선수명,
    p.position 포지션,
    '포항' ||t.team_name 팀명 ,
    s.stadium_name 스타디움,
    sc.sche_date 스케줄날짜
from team t
join player p
    on t.team_id like p.team_id
join stadium s
    on t.stadium_id like s.stadium_id
join schedule sc
    on sc.stadium_id like s.stadium_id
where sc.sche_date like '20120317'
    and p.position like 'GK'
    and t.team_name like '스틸러스'
order by p.player_name;
-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
select 
    s1.stadium_name 스타디움,
    sc. sche_date 경기날짜,
    sc.hometeam_id 홈팀,
    sc.awayteam_id 원정팀,
    sc.home_score "홈팀 점수",
    sc.away_score "원정팀 점수"
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
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
select 
s.stadium_name 스타디움,
sc. sche_date 경기날짜,
ht.region_name ||' '||ht.team_name 홈팀,
at.region_name ||' '||at.team_name 원정팀,
sc.home_score "홈팀 점수",
sc.away_score "원정팀 점수"
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
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
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
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- UNION VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02'
UNION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K07'
;
---- OR VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID LIKE 'K02' 
    OR T.TEAM_ID LIKE 'K07'
;
---- IN VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN ('K02', 'K07')
;

-- SOCCER_SQL_017
-- 소속이 삼성 블루윙즈 팀인 선수들과
-- 전남 드래곤즈팀인 선수들의 선수 정보
---- SUBQUERY VERSION
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID IN 
    ( (SELECT T.TEAM_ID
       FROM TEAM T
       WHERE T.TEAM_NAME 
        IN('드래곤즈','삼성블루윙즈')))
; 

-- 018
-- 최호진 선수의 소속팀과 포지션, 백넘버는 무엇입니까
select 
    p.player_name 선수명 ,
    t.team_name 팀이름 ,
    p.position 포지션,
    p.back_no 등번호
from player p
    join team t
        on p.team_id like t.team_id
        where p.player_name like '최호진'
;     

-- 019
-- 대전시티즌의 MF 평균키는 얼마입니까? 174.87
select
    round(avg (p.height),2) "대전시티즌MF평균키"
from player p
    join team t
        on p.team_id like t.team_id
where p.position like 'MF'
        and t.team_name like '시티즌'
    ;
--안나올때 다 찍어보기        
--select
--    *
--from player p
--    join team t
--      on p.team_id like t.team_id
--where p.position like 'MF'
--;
   
-- 020
-- 2012년 월별 경기수를 구하시오
select 
   (select 
   count(*) 
from schedule 
where sche_date like '201201%') "1월",
    (select 
    count(*)     
from schedule 
where sche_date like '201202%') "2월",
(select 
   count(*) 
from schedule 
where sche_date like '201203%') "3월",

(select 
   count(*) 
from schedule 
where sche_date like '201204%') "4월",

(select 
   count(*) 
from schedule 
where sche_date like '201205%') "5월",

(select 
   count(*) 
from schedule 
where sche_date like '201206%') "6월",

(select 
   count(*) 
from schedule 
where sche_date like '201207%') "7월",

(select 
   count(*) 
from schedule 
where sche_date like '201208%') "8월",

(select 
   count(*) 
from schedule 
where sche_date like '201209%') "9월",

(select 
   count(*) 
from schedule 
where sche_date like '201210%') "10월",

(select 
   count(*) 
from schedule 
where sche_date like '201211%') "11월",

(select 
   count(*) 
from schedule 
where sche_date like '201212%') "12월"

from dual;
select*from schedule;

-- 021
-- 2012년 월별 진행된 경기수(GUBUN IS YES)를 구하시오
-- 출력은 1월:20경기 이런식으로...
select 
   (select 
   count(*) 
from schedule 
where sche_date like '201201%')||'경기' "1월",
    (select 
    count(*)     
from schedule 
where sche_date like '201202%')||'경기' "2월",
(select 
   count(*) 
from schedule 
where sche_date like '201203%')||'경기' "3월",

(select 
   count(*) 
from schedule 
where sche_date like '201204%')||'경기' "4월",

(select 
   count(*) 
from schedule 
where sche_date like '201205%')||'경기' "5월",

(select 
   count(*) 
from schedule 
where sche_date like '201206%')||'경기' "6월",

(select 
   count(*) 
from schedule 
where sche_date like '201207%')||'경기' "7월",

(select 
   count(*) 
from schedule 
where sche_date like '201208%')||'경기' "8월",

(select 
   count(*) 
from schedule 
where sche_date like '201209%')||'경기' "9월",

(select 
   count(*) 
from schedule 
where sche_date like '201210%')||'경기' "10월",

(select 
   count(*) 
from schedule 
where sche_date like '201211%')||'경기' "11월",

(select 
   count(*) 
from schedule 
where sche_date like '201212%')||'경기' "12월"

from dual

;


-- 022
-- 2012년 9월 14일에 벌어질 경기는 어디와 어디입니까
-- 홈팀: ?   원정팀: ? 로 출력
select 
    ht.team_name 홈팀,
    at.team_name 원정팀
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
--GROUP BY 사용
--팀별 선수의 수
-- 아이파크 20명
--select 
--    count(p.player_id) 선수인원,
--        t.team_id 팀아이디
--from 
--    team t
--    join player p
--        on t.team_id like p.team_id
--group by 
--    t.team_id
--order by t.team_id
--   ;

select 
    count(p.player_id)||'명' 선수인원,
    (select a.team_name
    from team a
    where
        a.team_id like t.team_id
        )팀명
from 
    team t
    join player p
        on t.team_id like p.team_id
group by 
    t.team_id
order by t.team_name
;

select 
   count(p.player_id)|| '명' 선수인원,
    (select
    team_name 팀이름
from 
    team
where team_id like t.team_id)  팀명
from 
    team t
   join player p
        on t.team_id like p.team_id
group by 
    t.team_id
order by t.team_id
   ;
   
select
    team_name 팀이름
from 
    team
where team_id like 'K02'
;
-- 024 선수들 포지션 표시 공란이면 '없음'으로 표시
select
    player_name,
    position,
    case
        when position is null then '없음'
        when position like 'GK' then '골키퍼'
        when position like 'MF' then '미드필더'
        when position like 'FW' then '공격수'
        when position like 'DF' then '수비수'
        else position
    end 포지션
from
    player
where 
    team_id = 'K08'
;

--스칼라 안에 들어갈 내용
select team_name 팀명
from teamz
where team_id like 'ateam'
 ;
 
select
    player_name,
    position,
    case
        when position is null then '없음'
        when position like 'GK' then '골키퍼'
        when position like 'MF' then '미드필더'
        when position like 'FW' then '공격수'
        when position like 'DF' then '수비수'
        else position
    end 포지션
from
    player
where 
    team_id = 'K08'
; 

--025.키 순서대로 NO. 매기기(inline view 를 통해서)
--삼성블루윙즈에서 키 순으로 탑10 출력
select
    rownum "No. ",
    A.*
from (SELECT 
        T.TEAM_NAME 팀명,
        P.PLAYER_NAME 선수명,
        P.POSITION 포지션,
        P.BACK_NO 백넘버,
        P.HEIGHT 키
    FROM PLAYER P
        JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID
    WHERE 
    T.TEAM_ID  like (select t.team_id
                    from team t 
                    where t.team_name like '삼성블루윙즈')
                        and p.height is not null
                    ORDER BY P.HEIGHT DESC) A 
where rownum <=10
;
--키 순서대로 NO. 매기기(inline view 를 통해서)
--삼성블루윙즈에서 키 순으로 11-20위 까지 출력
select
    B.*
from
(select
    rownum "No. ",
    A.*
from (SELECT 
        T.TEAM_NAME 팀명,
        P.PLAYER_NAME 선수명,
        P.POSITION 포지션,
        P.BACK_NO 백넘버,
        P.HEIGHT 키
    FROM PLAYER P
        JOIN TEAM T
            ON P.TEAM_ID LIKE T.TEAM_ID
    WHERE 
    T.TEAM_ID  like (select t.team_id
                    from team t 
                    where t.team_name like '삼성블루윙즈')
        and p.height is not null
 
        
ORDER BY P.HEIGHT DESC) A ) B
where B."No. " between 11 and 20
;

--아이디만 아는 상태에서 삼성블루윙즈의 키순별 선수명단보기
SELECT 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수명,
    P.POSITION 포지션,
    P.BACK_NO 백넘버,
    P.HEIGHT 키
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE 
    T.TEAM_ID  like (select t.team_id
from team t 
where t.team_name like '삼성블루윙즈')
    and P.HEIGHT is not null 
ORDER BY P.HEIGHT DESC
;
--인라인뷰 서브쿼리
select team_id
from team
where team_name like '삼성블루윙즈'
;

-- 026.
-- 팀별 골키퍼의 평균 키에서
-- 가장 평균키가 큰 팀명은
select
    a.tname 팀명
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
-- 각 구단별 선수들 평균키가 삼성 블루윙즈팀의
-- 평균키보다 작은 팀의 이름과 해당 팀의 평균키를 
-- 구하시오
select b.*
from
(select 
    a.tname 팀명,
    a.hei 평균키,
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
-- 2012년 경기 중에서 점수차가 가장 큰 경기 전부
select 
   sc.sche_date 경기일,
   sc.hometeam_id || 홈팀 || 'VS' || sc.awayteam_id ||원정팀 
from stadium s
    join schedule sc
        on s.stadium_id like sc.stadium_id
where sc.home_score - sc.away_score
;
-- 029.
-- 좌석수대로 스타디움 순서 매기기
select
     rownum "NO. ",
    A.*
from (select 
    s.stadium_name 스타디움,
    s.seat_count 좌석수
    from stadium s
order by s.seat_count desc) A
;

select 
    s.stadium_name 스타디움,
    s.seat_count 좌석수
    from stadium s
order by s.seat_count desc;
-- 030.
-- 2012년 구단 승리 순으로 순위매기기

select
    sc.sche_date,
    case
        when sc.home_score > sc.away_score then ht.team_name
        when sc.away_score > sc.away_score then at.team_name
        else '무승부'
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
    a.winner 승리팀,
    count(a.winner) 승리
    
from
    (select
    sc.sche_date,
    case
        when sc.home_score > sc.away_score then ht.team_name
        when sc.away_score > sc.away_score then at.team_name
        else '무승부'
        end winner
from schedule sc
    join team ht 
       on sc.hometeam_id like ht.team_id
    join team at
       on sc.awayteam_id like at.team_id
where sc.sche_date like '2012%'
    and sc.gubun like 'Y')a
    where a.winner not like '무승부'
group by a.winner
order by 승리 desc
;


 select 
    a.winner 승리팀,
    count(a.winner) 승리
    from(select 
        sc.sche_date,
   case 
    when sc.home_score > sc.away_score then ht.team_name
    when sc.away_score > sc.home_score then at.team_name
    else '무승부'
    end winner
from schedule sc 
    join team ht
        on ht.team_id like sc.hometeam_id 
    join team at
        on at.team_id like sc.awayteam_id
where sc.gubun like 'Y'
    and sc.sche_date like '2012%')a
where a.winner not like '무승부'
group by a.winner
order by 승리 desc
;

select * from schedule;
select 
    sc.sche_date,
   case 
    when sc.home_score > sc.away_score then ht.team_name
    when sc.away_score > sc.home_score then at.team_name
    else '무승부'
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
    
    