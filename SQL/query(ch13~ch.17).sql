-- Active: 1724147702905@@127.0.0.1@3306@zb
use zb;
RENAME TABLE 2020_crime TO crime_status;
delete from crime_status;
ALTER TABLE crime_status DROP PRIMARY KEY;

-- 1. 새로운 컬럼 추가
ALTER TABLE crime_status ADD reference VARCHAR(255);

-- 2. 컬럼에 값 업데이트
UPDATE crime_status
SET reference = CONCAT('서울', 구분, '경찰서');


ALTER TABLE crime_status
ADD CONSTRAINT fk_reference
FOREIGN KEY (reference) REFERENCES police_station(name);

-- 3.police_station 의 primary key name과 fk reference를 이용해 join
select c.구분 , p.location
from crime_status c , police_station p
where c.reference = p.name
group by c.구분 ;

-- ch15. 3번 .종로경찰서와 남대문경찰서의 강도 발생 건수의 합을 구하세요.
select sum(c.건수) 
from crime_status c , police_station p
where c.reference = p.name and ((p.name ='서울종로경찰서' or p.name='서울남대문경찰서') and (c.죄종='강도'));

--4번.폭력 범죄의 검거 건수의 합을 구하세요.
select sum(c.건수)
from crime_status c , police_station p
where c.reference = p.name and (c.죄종 = '폭력' and c.발생검거='검거');

--1번. 살인의 평균 발생건수를 검색하고 확인하세요
select avg(c.건수)
from crime_status c , police_station p
where c.reference = p.name and (c.발생검거 = '발생' and c.죄종='살인');

--2번. 서초경찰서의 볌죄 별 평균 검거 건수를 검색하고 확인하세요
select distinct c.죄종, avg(c.건수)
from crime_status c , police_station p
where c.reference = p.name and (p.name='서울서초경찰서' and c.발생검거='검거')
group by c.죄종

--3번 
select avg(건수)
from crime_status 
where (reference = '서울구로경찰서' or reference ='서울도봉경찰서') and (죄종='살인' and 발생검거='검거');
--4번
select min(건수), 죄종
from crime_status
where reference='서울광진경찰서' and 발생검거='검거';
group by 죄종;
--5번
select min(건수), 죄종
from crime_status
where reference='서울성북경찰서' and 발생검거='발생';
group by 죄종;