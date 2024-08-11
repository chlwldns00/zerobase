use zb;
CREATE TABLE snl_show
(
ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
SEASON int NOT NULL,
EPISODE int NOT NULL,
BROADCAST_DATE date,
HOST varchar(32) NOT NULL
);
INSERT INTO snl_show VALUES (1, 8, 7, '2020-09-05','강동원'); 
INSERT INTO snl_show VALUES (2, 8, 8, '2020-09-12','유재석'); 
INSERT INTO snl_show VALUES (3, 8, 9, '2020-09-19','차승원'); 
INSERT INTO snl_show VALUES (4, 8, 10, '2020-09-26', '이수현'); 
INSERT INTO snl_show VALUES (5, 9, 1, '2021-09-04', '이병헌'); 
INSERT INTO snl_show VALUES (6, 9, 2, '2021-09-11', '하지원');
INSERT INTO snl_show VALUES (7, 9, 3, '2021-09-18', '제시'); 
INSERT INTO snl_show VALUES (8, 9, 4, '2021-09-25', '조정석'); 
INSERT INTO snl_show VALUES (9, 9, 5, '2021-10-02', '조여정'); 
INSERT INTO snl_show VALUES (10, 9, 6, '2021-10-09', '옥주현');

select * from snl_show;
select * from celeb;

# 9강 self join 예제 1
select c.ID, c.NAME, c.JOB_TITLE, s.SEASON, s.EPISODE
from celeb c, snl_show s
where c.NAME=s.HOST AND not(c.JOB_TITLE like'%영화배우%' or c.JOB_TITLE like '%텔런트%');

#9강 self join 예제2
select c.ID, c.NAME, c.JOB_TITLE, c.AGENCY
from celeb c, snl_show s
where c.NAME=s.HOST AND (s.BROADCAST_DATE > '2020-09-15' OR c.AGENCY not like '%엔터테이먼트') AND not(c.JOB_TITLE Like '%영화배우%' OR c.JOB_TITLE like '%개그맨%');

#10강 ALIAS혼자해봅시다 문제 1
select concat('이름 :',NAME,', 소속사:',AGENCY) 연예인정보
from celeb
where NAME LIKE '___';

#10강 ALIAS혼자해봅시다 문제 2
select AGENCY 소속사정보 , concat('나이 :',c.AGE,'(',c.SEX,')') 신상정보 , concat(s.SEASON,'-',s.EPISODE,', 방송날짜 :',s.BROADCAST_DATE) 출연정보
from celeb c , snl_show s
where c.AGENCY LIKE '__%' AND c.AGENCY LIKE '%엔터테이먼트'
