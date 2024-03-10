CREATE TABLE `users` (
  `USERID` varchar(50) NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `USERPASSWORD` varchar(50) NOT NULL,
  `USERAGE` int(11) NOT NULL,
  `USEREMAIL` varchar(50) NOT NULL,
  PRIMARY KEY (`USERID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `boards` (
  `bno` int(11) NOT NULL AUTO_INCREMENT,
  `BTITLE` varchar(100) NOT NULL DEFAULT '',
  `BCONTENT` text NOT NULL,
  `BWRITER` varchar(50) NOT NULL DEFAULT '',
  `BDATE` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`bno`)
) ENGIN;


/*
 *정적인 코드와 동적인 코드를 분리하기 위해서 나중에 브라우저로 확인할 것임 (HTML , CSS)
 * 오라클과 마리아 데베로 직관적으로 확인해봄
 * 
 * 자바에서  변경되는 점을 프로퍼티스를 이용해서 뺐음. 컴파일을 안하고 동작할 수 있도록 했음
 *  
 * 논리가 없는 파일 - HTML, css
 * 논리가 있는 파일 - JavaScript 
 * 
 * 
 * 
*/