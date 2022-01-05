@ECHO OFF
SET dirPath=F:\\freelance\\maven\\batchreports\\batchreports
CD  %dirPath%
CALL mvn spring-boot:run
PAUSE