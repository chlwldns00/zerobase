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


