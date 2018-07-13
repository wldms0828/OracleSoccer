select * from teamz;

create table teamz(
team_id varchar2(20) primary key,
team_name varchar2(20) );
insert into teamz values('ateam','Àú½ºÆ¼½º');
insert into teamz values('hteam','¿¤Ä«·Î');
insert into teamz values('cteam','°¡¿À°¶');
insert into teamz values('steam','¾îº¥Àú½º');

select * from teamw;
drop table teamw;
create table teamw(
    mem_id varchar2(20) primary key,
    team_id varchar2(20),
    mem_name varchar2(20),
    mem_ssn varchar2(20),
    roll varchar2(20));
alter table teamw add constraint teamz_fk_team_id
    FOREIGN KEY (team_id) REFERENCES teamz(team_id);
insert into teamw values('a1','ateam','ÇüÁØ','34','ÆÀÀå');
insert into teamw values('a2','ateam','¼¼ÀÎ','35','ÆÀ¿ø');
insert into teamw values('a3','ateam','ÈñÅÂ','21','ÆÀ¿ø');
insert into teamw values('a4','ateam','»óÈÆ','29','ÆÀ¿ø');
insert into teamw values('a5','ateam','ÅÂÇü','25','ÆÀ¿ø');
insert into teamw values('h1','hteam','Çý¸®','26','ÆÀÀå');
insert into teamw values('h2','hteam','ÁöÀº','26','ÆÀ¿ø');
insert into teamw values('h3','hteam','ÁØ','27','ÆÀ¿ø');
insert into teamw values('h4','hteam','Àç°æ','29','ÆÀ¿ø');
insert into teamw values('h5','hteam','´Ü¾Æ','26','ÆÀ¿ø');
insert into teamw values('c1','cteam','ÃÖÁ¤ÈÆ','32','ÆÀÀå');
insert into teamw values('c2','cteam','À±È£','31','ÆÀ¿ø');
insert into teamw values('c3','cteam','°¡Àº','29','ÆÀ¿ø');
insert into teamw values('c4','cteam','Á¤ÈÆ','23','ÆÀ¿ø');
insert into teamw values('c5','cteam','½ÂÅÂ','30','ÆÀ¿ø');
insert into teamw values('s1','steam','½ÂÈ£','27','ÆÀÀå');
insert into teamw values('s2','steam','¼ÒÁø','26','ÆÀ¿ø');
insert into teamw values('s3','steam','ÀÌ½½','29','ÆÀ¿ø');
insert into teamw values('s4','steam','ÁøÅÂ','26','ÆÀ¿ø');
insert into teamw values('s5','steam','´©¸®','30','ÆÀ¿ø');

UPDATE teamw SET  roll = 
    case 
        when mem_id like 'a1' then 'ÆÀÀå' 
        when mem_id like 'h1' then 'ÆÀÀå' 
        when mem_id like 'c1' then 'ÆÀÀå' 
        when mem_id like 's1' then 'ÆÀÀå' 
        else  'ÆÀ¿ø'
    end 
;
select * from teamw;
desc teamw

select (select team_name ÆÀ¸í
from teamz
where team_id like z.team_id) ÆÀ¸í,
    count(*) "ÆÀ¿øÀÇ ¼ö",
    sum(w.mem_age) "³ªÀÌÇÕ",
    max(w.mem_age) "³ªÀÌÀÇ ÃÖ´ëÄ¡",
    min(w.mem_age) "³ªÀÌÀÇ ÃÖ¼ÒÄ¡",
    avg(w.mem_age) ³ªÀÌÆò±Õ
    
    
from teamz z
    join teamw w
        on z.team_id like w.team_id
group by z.team_id
--having avg(w.mem_age) >= 28
order by z.team_id
;     

alter table teamz
rename to project_team;
alter table teamw
rename to member;