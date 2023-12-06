-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Club_DB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Club_DB` ;

-- -----------------------------------------------------
-- Schema Club_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Club_DB` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema club_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `club_db` ;

-- -----------------------------------------------------
-- Schema club_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `club_db` DEFAULT CHARACTER SET utf8 ;
USE `Club_DB` ;

-- -----------------------------------------------------
-- Table `Club_DB`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`person` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`person` (
  `SSN` INT NOT NULL,
  `FName` VARCHAR(12) NOT NULL,
  `LName` VARCHAR(12) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `BDATE` DATE NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Gender` CHAR(1) NOT NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Member` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Member` (
  `MembershipStartDate` DATE NOT NULL,
  `Member_SSN` INT NOT NULL,
  PRIMARY KEY (`Member_SSN`),
  CONSTRAINT `fk_Member_Perosn`
    FOREIGN KEY (`Member_SSN`)
    REFERENCES `Club_DB`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Pro_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Pro_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Pro_Player` (
  `Salary` FLOAT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  `Player_SSN` INT NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Player_Member1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Member` (`Member_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Employee` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Employee` (
  `Salary` FLOAT NULL,
  `Employee_SSN` INT NOT NULL,
  PRIMARY KEY (`Employee_SSN`),
  CONSTRAINT `fk_Employee_Perosn1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `Club_DB`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Coach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Coach` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Coach` (
  `StartDateCoaching` DATE NOT NULL,
  `Coach_SSN` INT NOT NULL,
  PRIMARY KEY (`Coach_SSN`),
  CONSTRAINT `fk_Coach_Employee1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Team` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Team` (
  `TeamName` VARCHAR(15) NOT NULL,
  `Coach_SSN` INT NOT NULL,
  PRIMARY KEY (`TeamName`),
  CONSTRAINT `fk_Team_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Event` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Event` (
  `Name` VARCHAR(45) NOT NULL,
  `Date` DATE NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Sponsor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Sponsor` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Sponsor` (
  `Name` VARCHAR(15) NOT NULL,
  `Website` VARCHAR(20) NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Sponsor_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `Club_DB`.`Event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Management`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Management` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Management` (
  `Name` VARCHAR(10) NOT NULL,
  `NumberOfEmployees` INT NOT NULL,
  `Manager_SSN` INT NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Management_Employee1`
    FOREIGN KEY (`Manager_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Catering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Catering` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Catering` (
  `Name` VARCHAR(25) NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `NumOfBranches` INT NOT NULL,
  `Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Catering_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Catering_Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Catering_Location` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Catering_Location` (
  `Location` VARCHAR(15) NOT NULL,
  `Supervisor_ssn` INT NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Location`, `Catering_Name`),
  CONSTRAINT `ay_haga`
    FOREIGN KEY (`Supervisor_ssn`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Catering_Location_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Place` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Place` (
  `Location` VARCHAR(15) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Hall` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Hall` (
  `NumberOfSeats` INT NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Hall_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Field`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Field` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Field` (
  `Area` FLOAT NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Field_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`CateringStaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`CateringStaff` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`CateringStaff` (
  `Worker_SSN` INT NOT NULL,
  `Catering_Location` VARCHAR(15) NOT NULL,
  `Catering_Location_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Worker_SSN`),
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`Worker_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CateringStaff_Catering_Location1`
    FOREIGN KEY (`Catering_Location` , `Catering_Location_Name`)
    REFERENCES `Club_DB`.`Catering_Location` (`Location` , `Catering_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Management_Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Management_Employee` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Management_Employee` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `Employee_SSN` INT NOT NULL,
  PRIMARY KEY (`Management_Name`, `Employee_SSN`),
  CONSTRAINT `fk_table2_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Management_Employee_Employee1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Event_Managment_Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Event_Managment_Place` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Event_Managment_Place` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Management_Name`, `PlaceName`, `Event_Name`),
  CONSTRAINT `fk_table3_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `Club_DB`.`Place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `Club_DB`.`Event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`TeamSport_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`TeamSport_player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`TeamSport_player` (
  `Player_SSN` INT NOT NULL,
  `TeamName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Team sport - player_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TeamSport_player_Team1`
    FOREIGN KEY (`TeamName`)
    REFERENCES `Club_DB`.`Team` (`TeamName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`individualSport_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`individualSport_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`individualSport_Player` (
  `Player_SSN` INT NOT NULL,
  `Coach_SSN` INT NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_individual sport - player_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_individual sport - player_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Menu` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Menu` (
  `optionNumber` INT NOT NULL,
  `option` VARCHAR(20) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`optionNumber`),
  CONSTRAINT `fk_Menu_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Menu-OpSize`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Menu-OpSize` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Menu-OpSize` (
  `Menu_optionNumber` INT NOT NULL,
  `Size` VARCHAR(1) NOT NULL,
  `Price` FLOAT NULL,
  CONSTRAINT `fk_Menu-OpSize_Menu1`
    FOREIGN KEY (`Menu_optionNumber`)
    REFERENCES `Club_DB`.`Menu` (`optionNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `club_db` ;

-- -----------------------------------------------------
-- Table `club_db`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`person` ;

CREATE TABLE IF NOT EXISTS `club_db`.`person` (
  `SSN` INT(11) NOT NULL,
  `FName` VARCHAR(12) NOT NULL,
  `LName` VARCHAR(12) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `phone` CHAR(11) NOT NULL,
  `BDATE` DATE NOT NULL,
  `Email` VARCHAR(40) NOT NULL,
  `Gender` CHAR(1) NOT NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`employee` ;

CREATE TABLE IF NOT EXISTS `club_db`.`employee` (
  `Salary` FLOAT NULL DEFAULT NULL,
  `Employee_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Employee_SSN`),
  CONSTRAINT `fk_Employee_Perosn1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `club_db`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`management`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`management` ;

CREATE TABLE IF NOT EXISTS `club_db`.`management` (
  `Name` VARCHAR(10) NOT NULL,
  `NumberOfEmployees` INT(11) NOT NULL,
  `Manager_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Management_Employee1`
    FOREIGN KEY (`Manager_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`catering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`catering` ;

CREATE TABLE IF NOT EXISTS `club_db`.`catering` (
  `Name` VARCHAR(25) NOT NULL,
  `Management_Name` VARCHAR(10) NOT NULL,
  `NumOfBranches` INT(11) NOT NULL,
  `Type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Catering_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `club_db`.`management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`catering_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`catering_location` ;

CREATE TABLE IF NOT EXISTS `club_db`.`catering_location` (
  `Location` VARCHAR(15) NOT NULL,
  `Supervisor_ssn` INT(11) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Location`, `Catering_Name`),
  CONSTRAINT `ay_haga`
    FOREIGN KEY (`Supervisor_ssn`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Catering_Location_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `club_db`.`catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`cateringstaff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`cateringstaff` ;

CREATE TABLE IF NOT EXISTS `club_db`.`cateringstaff` (
  `Worker_SSN` INT(11) NOT NULL,
  `Catering_Location` VARCHAR(15) NOT NULL,
  `Catering_Location_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Worker_SSN`),
  CONSTRAINT `fk_CateringStaff_Catering_Location1`
    FOREIGN KEY (`Catering_Location` , `Catering_Location_Name`)
    REFERENCES `club_db`.`catering_location` (`Location` , `Catering_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`Worker_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`coach`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`coach` ;

CREATE TABLE IF NOT EXISTS `club_db`.`coach` (
  `StartDateCoaching` DATE NOT NULL,
  `Coach_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Coach_SSN`),
  CONSTRAINT `fk_Coach_Employee1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`event` ;

CREATE TABLE IF NOT EXISTS `club_db`.`event` (
  `Name` VARCHAR(45) NOT NULL,
  `Date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`place` ;

CREATE TABLE IF NOT EXISTS `club_db`.`place` (
  `Location` VARCHAR(15) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`event_managment_place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`event_managment_place` ;

CREATE TABLE IF NOT EXISTS `club_db`.`event_managment_place` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Management_Name`, `PlaceName`, `Event_Name`),
  CONSTRAINT `fk_table3_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `club_db`.`event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `club_db`.`management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table3_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `club_db`.`place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`field`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`field` ;

CREATE TABLE IF NOT EXISTS `club_db`.`field` (
  `Area` FLOAT NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Field_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `club_db`.`place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`hall` ;

CREATE TABLE IF NOT EXISTS `club_db`.`hall` (
  `NumberOfSeats` INT(11) NOT NULL,
  `PlaceName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`PlaceName`),
  CONSTRAINT `fk_Hall_Place1`
    FOREIGN KEY (`PlaceName`)
    REFERENCES `club_db`.`place` (`PlaceName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`member` ;

CREATE TABLE IF NOT EXISTS `club_db`.`member` (
  `MembershipStartDate` DATE NOT NULL,
  `Member_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Member_SSN`),
  CONSTRAINT `fk_Member_Perosn`
    FOREIGN KEY (`Member_SSN`)
    REFERENCES `club_db`.`person` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`pro_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`pro_player` ;

CREATE TABLE IF NOT EXISTS `club_db`.`pro_player` (
  `Salary` FLOAT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  `Player_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Player_Member1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `club_db`.`member` (`Member_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`individualsport_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`individualsport_player` ;

CREATE TABLE IF NOT EXISTS `club_db`.`individualsport_player` (
  `Player_SSN` INT(11) NOT NULL,
  `Coach_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_individual sport - player_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `club_db`.`coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_individual sport - player_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `club_db`.`pro_player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`management_employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`management_employee` ;

CREATE TABLE IF NOT EXISTS `club_db`.`management_employee` (
  `Management_Name` VARCHAR(10) NOT NULL,
  `Employee_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`Management_Name`, `Employee_SSN`),
  CONSTRAINT `fk_Management_Employee_Employee1`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `club_db`.`employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table2_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `club_db`.`management` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`menu` ;

CREATE TABLE IF NOT EXISTS `club_db`.`menu` (
  `optionNumber` INT(11) NOT NULL,
  `option` VARCHAR(20) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`optionNumber`),
  CONSTRAINT `fk_Menu_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `club_db`.`catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`menu-opsize`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`menu-opsize` ;

CREATE TABLE IF NOT EXISTS `club_db`.`menu-opsize` (
  `Menu_optionNumber` INT(11) NOT NULL,
  `Size` VARCHAR(1) NOT NULL,
  `Price` FLOAT NULL DEFAULT NULL,
  CONSTRAINT `fk_Menu-OpSize_Menu1`
    FOREIGN KEY (`Menu_optionNumber`)
    REFERENCES `club_db`.`menu` (`optionNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`sponsor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`sponsor` ;

CREATE TABLE IF NOT EXISTS `club_db`.`sponsor` (
  `Name` VARCHAR(15) NOT NULL,
  `Website` VARCHAR(20) NULL DEFAULT NULL,
  `Event_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Name`),
  CONSTRAINT `fk_Sponsor_Event1`
    FOREIGN KEY (`Event_Name`)
    REFERENCES `club_db`.`event` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`team` ;

CREATE TABLE IF NOT EXISTS `club_db`.`team` (
  `TeamName` VARCHAR(15) NOT NULL,
  `Coach_SSN` INT(11) NOT NULL,
  PRIMARY KEY (`TeamName`),
  CONSTRAINT `fk_Team_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `club_db`.`coach` (`Coach_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `club_db`.`teamsport_player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `club_db`.`teamsport_player` ;

CREATE TABLE IF NOT EXISTS `club_db`.`teamsport_player` (
  `Player_SSN` INT(11) NOT NULL,
  `TeamName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Team sport - player_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `club_db`.`pro_player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TeamSport_player_Team1`
    FOREIGN KEY (`TeamName`)
    REFERENCES `club_db`.`team` (`TeamName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (1, "Eyad", "Khaled", "88 Shobra St., Shobra, Cairo", "01201945786", "1999-07-12", "M", "EyadKhaled70@gmail.com"),
(2, "Marawan", "Adel", "27 El Sadat, Al-Salam, Cairo", "01596328704", "2001-01-03", "M", "MarawanAdel259@gmail.com"),
(3, "Ahmed", "Adel", "58 Adly, Downtown, Cairo", "01141537906", "2004-07-11", "M", "AhmedAdel293@outlook.com"),
(4, "Haytham", "Sayed", "45 Gamal Abdel Nasser, Al-Salam, Cairo", "01507831945", "1995-04-04", "M", "HaythamSayed376@hotmail.com"),
(5, "Marawan", "Sayed", "41 Shaheen, Al Doqi, Giza", "01582360157", "1994-02-09", "M", "MarawanSayed46@gmail.com"),
(6, "Kareem", "Farag", "33 Sherif, Downtown, Cairo", "01156217983", "1993-06-03", "M", "KareemFarag144@outlook.com"),
(7, "Seif", "Nader", "52 18St. , ElTahrir City, Imbaba, Giza", "01131692875", "1999-03-10", "M", "SeifNader321@gmail.com"),
(8, "Mohamed", "Mohamed", "23 Gezira, Zamalek, Cairo", "01569584012", "2003-03-11", "M", "MohamedMohamed164@outlook.com"),
(9, "Haytham", "Ghanim", "9 Al Khamrawaya, Shobra, Cairo", "01141572980", "1995-01-14", "M", "HaythamGhanim274@hotmail.com"),
(10, "Abdelrahman", "Magdy", "90 151 St., Maadi, Cairo", "01071356028", "1987-12-12", "M", "AbdelrahmanMagdy212@hotmail.com"),
(11, "Mostafa", "Salah", "76 18St. , ElTahrir City, Imbaba, Giza", "01161078394", "1990-11-15", "M", "MostafaSalah28@gmail.com"),
(12, "Mostafa", "Ghanim", "71 Mohammed Mazhar, Zamalek, Cairo", "01042075938", "1998-12-05", "M", "MostafaGhanim203@hotmail.com"),
(13, "Abdelrahman", "Hani", "40 kamal Al Tawil, Zamalek, Cairo", "01282197054", "2001-03-19", "M", "AbdelrahmanHani231@hotmail.com"),
(14, "Omar", "Ezzat", "27 kamal Al Tawil, Zamalek, Cairo", "01260728395", "2002-12-27", "M", "OmarEzzat419@hotmail.com"),
(15, "Wael", "Sobhi", "44 Shaheen, Al Doqi, Giza", "01128530769", "2005-05-17", "M", "WaelSobhi158@hotmail.com"),
(16, "Wael", "Salah", "22 El Sadat, Al-Salam, Cairo", "01035062184", "1994-02-17", "M", "WaelSalah189@outlook.com"),
(17, "Marawan", "Fawzi", "45 Salah El Din, Heliopolis, Cairo", "01053786402", "1999-08-03", "M", "MarawanFawzi303@hotmail.com"),
(18, "Abdalaziz", "Zakaria", "15 kamal Al Tawil, Zamalek, Cairo", "01263597280", "1992-06-24", "M", "AbdalazizZakaria391@outlook.com"),
(19, "Marawan", "Farag", "3 151 St., Maadi, Cairo", "01584275319", "1997-12-19", "M", "MarawanFarag177@gmail.com"),
(20, "Mahmoud", "Zakaria", "52 Rod El Farag, Shobra, Cairo", "01556392708", "1987-08-25", "M", "MahmoudZakaria85@hotmail.com"),
(21, "Sherif", "Emad", "6 9 St., Maadi, Cairo", "01264593712", "2004-09-07", "M", "SherifEmad259@hotmail.com"),
(22, "Mohamed", "Salah", "75 Gamal Abdel Nasser, Al-Salam, Cairo", "01224916853", "1987-05-23", "M", "MohamedSalah311@gmail.com"),
(23, "Mahmoud", "Sobhi", "59 Shaheen, Al Doqi, Giza", "01261908243", "1995-08-13", "M", "MahmoudSobhi165@outlook.com"),
(24, "Adham", "Mohamed", "27 Hassan Sabry, Zamalek, Cairo", "01106783429", "2000-09-15", "M", "AdhamMohamed404@outlook.com"),
(25, "Mostafa", "Emad", "72 Al Ahram, Heliopolis, Cairo", "01024768530", "2004-01-10", "M", "MostafaEmad224@hotmail.com"),
(26, "Ehab", "Magdy", "48 Mohammed Mazhar, Zamalek, Cairo", "01091267054", "1995-06-19", "M", "EhabMagdy146@hotmail.com"),
(27, "Eyad", "Khalil", "35 Kholousi, Shobra, Cairo", "01291253806", "1993-05-25", "M", "EyadKhalil363@gmail.com"),
(28, "Marawan", "Farag", "26 Champeleon, Downtown, Cairo", "01175102869", "1994-07-26", "M", "MarawanFarag248@outlook.com"),
(29, "Seif", "Khalil", "69 El Sadat, Al-Salam, Cairo", "01112490563", "1989-07-15", "M", "SeifKhalil207@gmail.com"),
(30, "Amr", "Waleed", "32 Al Nahda, Maadi, Cairo", "01550278394", "1989-05-22", "M", "AmrWaleed158@hotmail.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (1, "2019-02-17"),
(2, "2014-06-06"),
(3, "2022-10-03"),
(4, "2006-10-18"),
(5, "2006-09-22"),
(6, "2011-12-28"),
(7, "2020-10-15"),
(8, "2008-06-20"),
(9, "2022-02-26"),
(10, "2016-08-07"),
(11, "2005-10-03"),
(12, "2022-05-03"),
(13, "2018-01-01"),
(14, "2005-08-02"),
(15, "2008-07-24"),
(16, "2005-04-16"),
(17, "2008-04-10"),
(18, "2017-07-15"),
(19, "2012-10-12"),
(20, "2019-08-06"),
(21, "2011-08-02"),
(22, "2010-12-16"),
(23, "2019-06-20"),
(24, "2008-12-22"),
(25, "2008-11-17"),
(26, "2010-02-25"),
(27, "2013-03-23"),
(28, "2018-06-12"),
(29, "2007-12-17"),
(30, "2013-11-07");
INSERT INTO Pro_Player (Player_SSN, Salary, SportName) VALUES
 (1, 340348, 'Football'),
(2, 272565, 'Football'),
(3, 295691, 'Football'),
(4, 256291, 'Football'),
(5, 393853, 'Football'),
(6, 312652, 'Football'),
(7, 354581, 'Football'),
(8, 239884, 'Football'),
(9, 424259, 'Football'),
(10, 374765, 'Football'),
(11, 254038, 'Football'),
(12, 299547, 'Football'),
(13, 201455, 'Football'),
(14, 327271, 'Football'),
(15, 397927, 'Football'),
(16, 325890, 'Football'),
(17, 348022, 'Football'),
(18, 221321, 'Football'),
(19, 336913, 'Football'),
(20, 427582, 'Football'),
(21, 448583, 'Football'),
(22, 255376, 'Football'),
(23, 379808, 'Football'),
(24, 364073, 'Football'),
(25, 303344, 'Football'),
(26, 216058, 'Football'),
(27, 422043, 'Football'),
(28, 291799, 'Football'),
(29, 399375, 'Football'),
(30, 440985, 'Football');
INSERT INTO TeamSport_Player (Player_SSN, TeamName) VALUES
 (1, "First Team"),
(2, "First Team"),
(3, "First Team"),
(4, "First Team"),
(5, "First Team"),
(6, "First Team"),
(7, "First Team"),
(8, "First Team"),
(9, "First Team"),
(10, "First Team"),
(11, "First Team"),
(12, "First Team"),
(13, "First Team"),
(14, "First Team"),
(15, "First Team"),
(16, "First Team"),
(17, "First Team"),
(18, "First Team"),
(19, "First Team"),
(20, "First Team"),
(21, "First Team"),
(22, "First Team"),
(23, "First Team"),
(24, "First Team"),
(25, "First Team"),
(26, "First Team"),
(27, "First Team"),
(28, "First Team"),
(29, "First Team"),
(30, "First Team");
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(31, "Abdalaziz", "Hassan", "96 Al Kanal, Maadi, Cairo", "01103572189", "2009-04-04", "M", "AbdalazizHassan53@outlook.com"),
(32, "Ehab", "Zakaria", "65 El Sadat, Al-Salam, Cairo", "01223497150", "2007-08-21", "M", "EhabZakaria106@hotmail.com"),
(33, "Omar", "Farag", "77 Shagaret Al Dor, Zamalek, Cairo", "01154273916", "2007-10-08", "M", "OmarFarag236@gmail.com"),
(34, "Zeyad", "Ghanim", "85 9 St., Maadi, Cairo", "01554719368", "2007-02-25", "M", "ZeyadGhanim406@outlook.com"),
(35, "Wael", "Adel", "98 Gamal Abdel Nasser, Al-Salam, Cairo", "01284730261", "2006-11-21", "M", "WaelAdel293@outlook.com"),
(36, "Marawan", "Sayed", "95 Al Nadi, Maadi, Cairo", "01135218906", "2005-09-17", "M", "MarawanSayed308@hotmail.com"),
(37, "Abdelrahman", "Emad", "49 Shaheen, Al Doqi, Giza", "01005216973", "2009-09-17", "M", "AbdelrahmanEmad420@gmail.com"),
(38, "Adham", "Ashraf", "15 18St. , ElTahrir City, Imbaba, Giza", "01116732890", "2006-04-01", "M", "AdhamAshraf86@hotmail.com"),
(39, "Zeyad", "Sobhi", "49 Al Nahda, Maadi, Cairo", "01250916284", "2005-10-19", "M", "ZeyadSobhi255@gmail.com"),
(40, "Abdalaziz", "Khalil", "56 Rod El Farag, Shobra, Cairo", "01520849713", "2006-02-24", "M", "AbdalazizKhalil64@outlook.com"),
(41, "Eyad", "Yaser", "94 Taha Hussein, Zamalek, Cairo", "01017482603", "2007-08-02", "M", "EyadYaser412@gmail.com"),
(42, "Amr", "Magdy", "70 Ahmed Helmy, Shobra, Cairo", "01286123709", "2005-05-08", "M", "AmrMagdy391@hotmail.com"),
(43, "Seif", "Khalil", "93 28St. ,ElTahrir City, Imbaba, Giza", "01580761935", "2005-09-10", "M", "SeifKhalil359@outlook.com"),
(44, "Ali", "Nader", "98 Al Nozha, Heliopolis, Cairo", "01236809251", "2005-12-17", "M", "AliNader194@outlook.com"),
(45, "Marawan", "Khalil", "24 Gad Eid, Al Doqi, Giza", "01262347058", "2009-11-10", "M", "MarawanKhalil11@outlook.com"),
(46, "Omar", "Emad", "71 Al Merghany, Heliopolis, Cairo", "01005124369", "2004-02-10", "M", "OmarEmad110@hotmail.com"),
(47, "Abdalaziz", "Khalil", "69 Gamal Abdel Nasser, Al-Salam, Cairo", "01264753192", "2006-06-22", "M", "AbdalazizKhalil165@hotmail.com"),
(48, "Wael", "Zakaria", "57 El Sadat, Al-Salam, Cairo", "01232765019", "2006-03-20", "M", "WaelZakaria220@outlook.com"),
(49, "Yousif", "Magdy", "77 Al Nozha, Heliopolis, Cairo", "01095786123", "2004-01-11", "M", "YousifMagdy138@gmail.com"),
(50, "Abdelrahman", "Farag", "47 18St. , ElTahrir City, Imbaba, Giza", "01217692384", "2005-02-04", "M", "AbdelrahmanFarag216@hotmail.com"),
(51, "Ahmed", "Sobhi", "9 Al Kanal, Maadi, Cairo", "01521870536", "2006-01-06", "M", "AhmedSobhi48@gmail.com"),
(52, "Abdalaziz", "Sayed", "32 Al Merghany, Heliopolis, Cairo", "01095140832", "2007-01-13", "M", "AbdalazizSayed301@hotmail.com"),
(53, "Zeyad", "Emad", "46 Shagaret Al Dor, Zamalek, Cairo", "01184627105", "2006-12-05", "M", "ZeyadEmad32@outlook.com"),
(54, "Omar", "Yaser", "80 Taha Hussein, Zamalek, Cairo", "01270135986", "2007-10-16", "M", "OmarYaser172@gmail.com"),
(55, "Mahmoud", "Salah", "53 kamal Al Tawil, Zamalek, Cairo", "01128057691", "2008-10-28", "M", "MahmoudSalah17@outlook.com"),
(56, "Eyad", "Ezzat", "29 Shaheen, Al Doqi, Giza", "01053916720", "2007-09-26", "M", "EyadEzzat143@gmail.com"),
(57, "Haytham", "Khalil", "10 15 May, Shobra, Cairo", "01057396128", "2008-06-26", "M", "HaythamKhalil388@hotmail.com"),
(58, "Abdelrahman", "Adel", "72 Al Merghany, Heliopolis, Cairo", "01528906457", "2008-02-17", "M", "AbdelrahmanAdel420@hotmail.com"),
(59, "Ehab", "Mohamed", "52 151 St., Maadi, Cairo", "01225730168", "2006-07-04", "M", "EhabMohamed397@gmail.com"),
(60, "Yousif", "Ashraf", "19 Shobra St., Shobra, Cairo", "01065329704", "2006-07-22", "M", "YousifAshraf292@outlook.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
(31, "2010-05-27"),
(32, "2022-10-03"),
(33, "2022-12-06"),
(34, "2011-08-18"),
(35, "2009-06-16"),
(36, "2015-10-22"),
(37, "2011-07-21"),
(38, "2015-03-19"),
(39, "2013-07-01"),
(40, "2015-09-21"),
(41, "2017-06-11"),
(42, "2022-02-06"),
(43, "2015-06-17"),
(44, "2012-08-19"),
(45, "2012-01-28"),
(46, "2016-09-05"),
(47, "2018-07-19"),
(48, "2019-01-05"),
(49, "2010-12-10"),
(50, "2017-01-14"),
(51, "2017-02-17"),
(52, "2021-09-28"),
(53, "2021-11-15"),
(54, "2010-08-09"),
(55, "2015-08-15"),
(56, "2021-11-02"),
(57, "2022-08-23"),
(58, "2019-05-27"),
(59, "2013-03-23"),
(60, "2018-03-21");
INSERT INTO Pro_Player (Player_SSN, Salary, SportName) VALUES
(31, 105897, 'Football'),
(32, 107581, 'Football'),
(33, 111508, 'Football'),
(34, 132274, 'Football'),
(35, 85301, 'Football'),
(36, 148482, 'Football'),
(37, 117454, 'Football'),
(38, 122758, 'Football'),
(39, 166463, 'Football'),
(40, 117180, 'Football'),
(41, 83662, 'Football'),
(42, 84210, 'Football'),
(43, 162362, 'Football'),
(44, 94277, 'Football'),
(45, 174653, 'Football'),
(46, 88820, 'Football'),
(47, 165677, 'Football'),
(48, 79844, 'Football'),
(49, 114591, 'Football'),
(50, 108751, 'Football'),
(51, 165111, 'Football'),
(52, 128909, 'Football'),
(53, 130339, 'Football'),
(54, 95712, 'Football'),
(55, 130746, 'Football'),
(56, 116094, 'Football'),
(57, 152971, 'Football'),
(58, 145958, 'Football'),
(59, 104815, 'Football'),
(60, 79687, 'Football');
INSERT INTO TeamSport_Player (Player_SSN, TeamName) VALUES
 (31, "Academy Team"),
(32, "Academy Team"),
(33, "Academy Team"),
(34, "Academy Team"),
(35, "Academy Team"),
(36, "Academy Team"),
(37, "Academy Team"),
(38, "Academy Team"),
(39, "Academy Team"),
(40, "Academy Team"),
(41, "Academy Team"),
(42, "Academy Team"),
(43, "Academy Team"),
(44, "Academy Team"),
(45, "Academy Team"),
(46, "Academy Team"),
(47, "Academy Team"),
(48, "Academy Team"),
(49, "Academy Team"),
(50, "Academy Team"),
(51, "Academy Team"),
(52, "Academy Team"),
(53, "Academy Team"),
(54, "Academy Team"),
(55, "Academy Team"),
(56, "Academy Team"),
(57, "Academy Team"),
(58, "Academy Team"),
(59, "Academy Team"),
(60, "Academy Team");
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (61, "Eyad", "Fawzi", "33 Baghdad, Heliopolis, Cairo", "01101369785", "2000-09-19", "M", "EyadFawzi56@gmail.com"),
(62, "Abdelrahman", "Magdy", "5 Shaheen, Al Doqi, Giza", "01020819347", "1996-06-15", "M", "AbdelrahmanMagdy322@outlook.com"),
(63, "Wael", "Waleed", "62 Al Saad Al Aaly, Maadi, Cairo", "01259461703", "2002-06-08", "M", "WaelWaleed129@gmail.com"),
(64, "Amr", "Khaled", "29 Talaat Harb, Downtown, Cairo", "01285216497", "2001-05-04", "M", "AmrKhaled206@hotmail.com"),
(65, "Amir", "Khaled", "38 El Tahrir, Downtown, Cairo", "01215684032", "2002-08-02", "M", "AmrKhaled321@hotmail.com"),
(66, "Kareem", "Fawzi", "69 Damascus, Maadi, Cairo", "01264159832", "1997-07-17", "M", "KareemFawzi94@outlook.com"),
(67, "Zeyad", "Emad", "70 Gamal Abdel Nasser, Al-Salam, Cairo", "01246708531", "2001-03-14", "M", "ZeyadEmad151@outlook.com"),
(68, "Yousif", "Sayed", "86 Damascus, Maadi, Cairo", "01019573620", "1996-04-27", "M", "YousifSayed83@hotmail.com"),
(69, "Wael", "Hani", "60 Shaheen, Al Doqi, Giza", "01554302168", "1994-10-23", "M", "WaelHani191@gmail.com"),
(70, "Ibrahim", "Khalil", "8 Gad Eid, Al Doqi, Giza", "01183019652", "1998-02-09", "M", "IbrahimKhalil350@hotmail.com"),
(71, "Mostafa", "Ezzat", "92 Gamal Abdel Nasser, Al-Salam, Cairo", "01048630579", "2001-07-11", "M", "MostafaEzzat139@gmail.com"),
(72, "Marawan", "Adel", "60 Baghdad, Heliopolis, Cairo", "01105267481", "1996-10-10", "M", "MarawanAdel177@gmail.com"),
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
(61, "2021-04-07"),
(62, "2017-12-28"),
(63, "2016-04-15"),
(64, "2015-12-03"),
(65, "2022-07-08"),
(66, "2020-12-21"),
(67, "2016-08-11"),
(68, "2017-05-11"),
(69, "2021-01-13"),
(70, "2023-01-09"),
(71, "2021-12-12"),
(72, "2018-02-18"),
INSERT INTO Pro_Player (Player_SSN, Salary, SportName) VALUES
 (61, 139466, 'Basketball'),
(62, 128283, 'Basketball'),
(63, 179373, 'Basketball'),
(64, 131433, 'Basketball'),
(65, 106690, 'Basketball'),
(66, 160089, 'Basketball'),
(67, 179020, 'Basketball'),
(68, 128675, 'Basketball'),
(69, 133025, 'Basketball'),
(70, 173693, 'Basketball'),
(71, 109194, 'Basketball'),
(72, 129522, 'Basketball');
INSERT INTO TeamSport_Player (Player_SSN, TeamName) VALUES
 (61, "Mens Team"),
(62, "Mens Team"),
(63, "Mens Team"),
(64, "Mens Team"),
(65, "Mens Team"),
(66, "Mens Team"),
(67, "Mens Team"),
(68, "Mens Team"),
(69, "Mens Team"),
(70, "Mens Team"),
(71, "Mens Team"),
(72, "Mens Team");
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (73, "Nourhan", "Hani", "50 26 July St, Downtown, Cairo", "01106753149", "2000-10-08", "M", "NourhanHani409@hotmail.com"),
(74, "Arwa", "Ashraf", "51 Al Merghany, Heliopolis, Cairo", "01295476231", "2005-08-02", "M", "ArwaAshraf34@gmail.com"),
(75, "Noureen", "Sobhi", "31 18St. , ElTahrir City, Imbaba, Giza", "01194201756", "2002-07-04", "M", "NoureenSobhi33@hotmail.com"),
(76, "Nada", "Ashraf", "75 Mamdouh Salem, Imbaba, Giza", "01078504312", "2004-03-03", "M", "NadaAshraf175@gmail.com"),
(77, "Hager", "Ghanim", "38 28St. ,ElTahrir City, Imbaba, Giza", "01558743019", "1998-06-05", "M", "HagerGhanim231@outlook.com"),
(78, "Esraa", "Khaled", "81 Al Hegaz, Heliopolis, Cairo", "01047380925", "2000-03-09", "M", "EsraaKhaled355@outlook.com"),
(79, "Salma", "Khaled", "35 Sherif, Downtown, Cairo", "01285309146", "1995-11-12", "M", "SalmaKhaled17@gmail.com"),
(80, "Arwa", "Khaled", "74 Shobra St., Shobra, Cairo", "01531489275", "2003-12-09", "M", "ArwaKhaled270@hotmail.com"),
(81, "Salma", "Salah", "72 Adly, Downtown, Cairo", "01531768420", "2000-05-14", "M", "SalmaSalah344@hotmail.com"),
(82, "Nada", "Ghanim", "58 Al Khamrawaya, Shobra, Cairo", "01297852643", "1994-06-22", "M", "NadaGhanim180@gmail.com"),
(83, "Omnya", "Nader", "6 Al Ahram, Heliopolis, Cairo", "01540915268", "1996-05-12", "M", "OmnyaNader89@hotmail.com"),
(84, "Aya", "Sobhi", "30 Al Teraa Al Boulakeya, Shobra, Cairo", "01126318094", "1997-12-21", "M", "AyaSobhi381@outlook.com"),
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (73, "2020-03-21"),
(74, "2019-02-22"),
(75, "2021-08-06"),
(76, "2017-09-09"),
(77, "2020-07-15"),
(78, "2016-04-22"),
(79, "2016-02-11"),
(80, "2019-11-26"),
(81, "2019-06-12"),
(82, "2020-02-26"),
(83, "2021-08-21"),
(84, "2022-03-20"),
INSERT INTO Pro_Player (Player_SSN, Salary, SportName) VALUES
 (73, 94840, 'Basketball'),
(74, 98901, 'Basketball'),
(75, 97170, 'Basketball'),
(76, 104785, 'Basketball'),
(77, 112270, 'Basketball'),
(78, 116858, 'Basketball'),
(79, 93289, 'Basketball'),
(80, 91399, 'Basketball'),
(81, 108107, 'Basketball'),
(82, 104849, 'Basketball'),
(83, 97081, 'Basketball'),
(84, 100054, 'Basketball');
INSERT INTO TeamSport_Player (Player_SSN, TeamName) VALUES
 (73, "Womens Team"),
(74, "Womens Team"),
(75, "Womens Team"),
(76, "Womens Team"),
(77, "Womens Team"),
(78, "Womens Team"),
(79, "Womens Team"),
(80, "Womens Team"),
(81, "Womens Team"),
(82, "Womens Team"),
(83, "Womens Team"),
(84, "Womens Team");
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (85, "Abdalaziz", "Yaser", "42 Al Saad Al Aaly, Maadi, Cairo", "01276213495", "2004-07-12", "M", "AbdalazizYaser193@outlook.com"),
(86, "Mohamed", "Fawzi", "64 Al Saad Al Aaly, Maadi, Cairo", "01220674581", "2000-01-17", "M", "MohamedFawzi162@hotmail.com"),
(87, "Noureen", "Sobhi", "16 Al Merghany, Heliopolis, Cairo", "01275480369", "1994-09-01", "F", "NoureenSobhi262@gmail.com"),
(88, "Ehab", "Ashraf", "90 9 St., Maadi, Cairo", "01051463092", "1999-08-22", "M", "EhabAshraf6@hotmail.com"),
(89, "Aya", "Hassan", "17 Talaat Harb, Downtown, Cairo", "01065320987", "1994-07-05", "F", "AyaHassan361@gmail.com"),
(90, "Yousif", "Yaser", "32 Gamal Abdel Nasser, Al-Salam, Cairo", "01596231748", "2001-03-12", "M", "YousifYaser278@gmail.com"),
(91, "Kareem", "Ezzat", "19 Al Nozha, Heliopolis, Cairo", "01235790148", "2001-02-17", "M", "KareemEzzat315@outlook.com"),
(92, "Ali", "Magdy", "86 kamal Al Tawil, Zamalek, Cairo", "01549027158", "2001-10-11", "M", "AliMagdy98@hotmail.com"),
(93, "Kareem", "Zakaria", "43 Gad Eid, Al Doqi, Giza", "01101942786", "1999-05-08", "M", "KareemZakaria100@hotmail.com"),
(94, "Ibrahim", "Emad", "80 Al Merghany, Heliopolis, Cairo", "01145601327", "1995-04-17", "M", "IbrahimEmad311@outlook.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (85, "2021-08-15"),
(86, "2022-12-19"),
(87, "2017-03-08"),
(88, "2015-07-12"),
(89, "2018-04-09"),
(90, "2019-05-13"),
(91, "2023-10-15"),
(92, "2015-09-27"),
(93, "2015-09-20"),
(94, "2019-01-13");
INSERT INTO Pro_Player (Player_SSN, Salary, SportName) VALUES
 (85, 51255, 'Swimming'),
(86, 76390, 'Swimming'),
(87, 54326, 'Swimming'),
(88, 71551, 'Swimming'),
(89, 56529, 'Swimming'),
(90, 56834, 'Swimming'),
(91, 53113, 'Swimming'),
(92, 69354, 'Swimming'),
(93, 85811, 'Swimming'),
(94, 77275, 'Swimming');
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (95, "Aya", "Yaser", "9 Al Nahda, Maadi, Cairo", "01141387965", "2004-03-24", "F", "AyaYaser17@gmail.com"),
(96, "Mostafa", "Farag", "20 Talaat Harb, Imbaba, Giza", "01191075823", "1994-03-11", "M", "MostafaFarag336@outlook.com"),
(97, "Yousif", "Sobhi", "95 Gezira, Zamalek, Cairo", "01501938642", "2003-06-24", "M", "YousifSobhi349@hotmail.com"),
(98, "Abdelrahman", "Fawzi", "9 Al Nadi, Maadi, Cairo", "01286971035", "1997-06-22", "M", "AbdelrahmanFawzi48@hotmail.com"),
(99, "Eyad", "Khalil", "65 Hassan Ramadan, Al Doqi, Giza", "01015930864", "1995-04-27", "M", "EyadKhalil152@hotmail.com"),
(100, "Mariam", "Khaled", "96 Al Ahram, Heliopolis, Cairo", "01109861357", "2003-02-17", "F", "MariamKhaled189@outlook.com"),
(101, "Mostafa", "Fawzi", "57 Shaheen, Al Doqi, Giza", "01156017924", "2003-12-16", "M", "MostafaFawzi181@outlook.com"),
(102, "Ehab", "Hani", "52 Al Kanal, Maadi, Cairo", "01156947108", "2004-01-14", "M", "EhabHani57@outlook.com"),
(103, "Mahmoud", "Adel", "82 Gad Eid, Al Doqi, Giza", "01585069732", "2002-03-27", "M", "MahmoudAdel335@hotmail.com"),
(104, "Yara", "Waleed", "77 28St. ,ElTahrir City, Imbaba, Giza", "01090851326", "1995-07-09", "F", "YaraWaleed351@hotmail.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (95, "2015-02-09"),
(96, "2022-01-03"),
(97, "2016-07-22"),
(98, "2020-02-02"),
(99, "2017-11-03"),
(100, "2022-11-14"),
(101, "2015-09-07"),
(102, "2018-01-18"),
(103, "2017-01-25"),
(104, "2015-02-24");
INSERT INTO Pro_Player (Player_SSN, Salary, SportName) VALUES
(95, 73710, 'Kung Fu'),
(96, 88335, 'Kung Fu'),
(97, 69402, 'Kung Fu'),
(98, 84638, 'Kung Fu'),
(99, 83078, 'Kung Fu'),
(100, 47062, 'Kung Fu'),
(101, 89653, 'Kung Fu'),
(102, 55698, 'Kung Fu'),
(103, 79954, 'Kung Fu'),
(104, 57287, 'Kung Fu');
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(105, "Abdelrahman", "Ezzat", "39 El Sadat, Al-Salam, Cairo", "01038946025", "1980-05-08", "M", "AbdelrahmanEzzat272@gmail.com"),
(106, "Amr", "Yaser", "41 Doletyan, Shobra, Cairo", "01072391806", "1989-04-10", "M", "AmrYaser143@hotmail.com"),
(107, "Ahmed", "Emad", "52 Bahgat Ali, Zamalek, Cairo", "01510974382", "1990-09-27", "M", "AhmedEmad190@gmail.com"),
(108, "Hager", "Khalil", "3 Mamdouh Salem, Imbaba, Giza", "01030874591", "1991-09-13", "F", "HagerKhalil191@outlook.com"),
(109, "Wael", "Emad", "13 15 May, Shobra, Cairo", "01260819473", "1981-02-28", "M", "WaelEmad277@outlook.com"),
(110, "Esraa", "Fawzi", "46 Gad Eid, Al Doqi, Giza", "01235672841", "1979-11-03", "F", "EsraaFawzi55@hotmail.com"),
(111, "Kareem", "Khalil", "72 El Tahrir, Downtown, Cairo", "01038194672", "1994-10-13", "M", "KareemKhalil245@outlook.com"),
(112, "Yasmin", "Adel", "28 Talaat Harb, Downtown, Cairo", "01029680735", "1976-09-27", "F", "YasminAdel247@outlook.com"),
(113, "Hana", "Sayed", "75 Shaheen, Al Doqi, Giza", "01168453297", "1976-03-11", "F", "HanaSayed99@hotmail.com"),
(114, "Ehab", "Farag", "81 Taha Hussein, Zamalek, Cairo", "01528534970", "1987-08-06", "M", "EhabFarag0@gmail.com"),
INSERT INTO Employee (Employee_SSN,salary) VALUES
(105, 119029),
(106, 130876),
(107, 90226),
(108, 116832),
(109, 83893),
(110, 99694),
(111, 117012),
(112, 96591),
(113, 97963),
(114, 79940);
INSERT INTO Coach (Coach_SSN, StartDateCoaching) VALUES
(105, "2015-10-25"),
(106, "2022-02-27"),
(107, "2019-03-28"),
(108, "2023-08-18"),
(109, "2015-09-09"),
(110, "2018-10-14"),
(111, "2017-08-09"),
(112, "2015-07-22"),
(113, "2016-03-22"),
(114, "2021-09-14");
INSERT INTO Team(TeamName,Coach_SSN)  Values 
("First Team",105),
("Academy Team",106),
("Mens Team",107),
("Womens Team",108);
INSERT INTO individualSport_player (coach_ssn, player_ssn) VALUES 
(109,85),
(109,86),
(109,87),
(109,88),
(110,89),
(110,90),
(110,91),
(111,92),
(111,93),
(111,94),
(112,95),
(112,96),
(112,97),
(113,98),
(113,99),
(113,100),
(113,101),
(114,102),
(114,103),
(114,104);
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(115, "Aya", "Ezzat", "90 Kholousi, Shobra, Cairo", "01212950786", "2019-07-26", "F", "AyaEzzat265@hotmail.com"),
(116, "Mahmoud", "Zakaria", "23 151 St., Maadi, Cairo", "01228905416", "1974-12-04", "M", "MahmoudZakaria299@hotmail.com"),
(117, "Marawan", "Ghanim", "61 18St. , ElTahrir City, Imbaba, Giza", "01076905423", "2011-02-25", "M", "MarawanGhanim187@hotmail.com"),
(118, "Shahd", "Ashraf", "17 151 St., Maadi, Cairo", "01029560741", "1972-09-22", "F", "ShahdAshraf124@hotmail.com"),
(119, "Kareem", "Khalil", "95 Hassan Sabry, Zamalek, Cairo", "01029076415", "1980-06-13", "M", "KareemKhalil297@outlook.com"),
(120, "Omnya", "Hani", "78 Al Ahram, Heliopolis, Cairo", "01520839745", "1960-04-12", "F", "OmnyaHani250@hotmail.com"),
(121, "Ali", "Nader", "72 Taha Hussein, Zamalek, Cairo", "01048392160", "2013-10-10", "M", "AliNader306@gmail.com"),
(122, "Mariam", "Salah", "99 18St. , ElTahrir City, Imbaba, Giza", "01505672381", "2000-04-02", "F", "MariamSalah194@gmail.com"),
(123, "Nourhan", "Yaser", "50 Al Merghany, Heliopolis, Cairo", "01269820351", "1972-01-01", "F", "NourhanYaser164@hotmail.com"),
(124, "Toaa", "Fawzi", "92 Shaheen, Al Doqi, Giza", "01572394085", "1961-04-27", "F", "ToaaFawzi32@outlook.com"),
(125, "Shahd", "Ghanim", "42 Kholousi, Shobra, Cairo", "01268352907", "2004-11-06", "F", "ShahdGhanim128@hotmail.com"),
(126, "Hana", "Mohamed", "86 Al Saad Al Aaly, Maadi, Cairo", "01178019432", "1971-12-27", "F", "HanaMohamed372@hotmail.com"),
(127, "Ahmed", "Ashraf", "66 Hassan Ramadan, Al Doqi, Giza", "01001298675", "2008-01-27", "M", "AhmedAshraf71@gmail.com"),
(128, "Esraa", "Fawzi", "78 Sherif, Downtown, Cairo", "01595130678", "2001-06-19", "F", "EsraaFawzi141@outlook.com"),
(129, "Ahmed", "Adel", "15 Shaheen, Al Doqi, Giza", "01212456980", "1964-05-06", "M", "AhmedAdel97@hotmail.com"),
(130, "Nour", "Hani", "69 Salah El Din, Heliopolis, Cairo", "01523601987", "1978-11-28", "F", "NourHani231@hotmail.com"),
(131, "Marawan", "Adel", "8 El Tahrir, Downtown, Cairo", "01020478163", "2015-10-15", "M", "MarawanAdel389@hotmail.com"),
(132, "Sherif", "Waleed", "59 Adly, Downtown, Cairo", "01520169785", "1974-11-01", "M", "SherifWaleed396@gmail.com"),
(133, "Ibrahim", "Nader", "95 Gad Eid, Al Doqi, Giza", "01140897325", "2017-09-18", "M", "IbrahimNader129@outlook.com"),
(134, "Ali", "Adel", "83 Hassan Sabry, Zamalek, Cairo", "01041578392", "2016-12-26", "M", "AliAdel168@outlook.com"),
(135, "Dina", "Zakaria", "78 Gamal Abdel Nasser, Al-Salam, Cairo", "01130142958", "2000-07-01", "F", "DinaZakaria238@hotmail.com"),
(136, "Amir", "Ghanim", "56 Hassan Ramadan, Al Doqi, Giza", "01278413962", "1976-09-13", "M", "AmirGhanim296@gmail.com"),
(137, "Hana", "Ghanim", "41 26 July St, Downtown, Cairo", "01529506374", "1960-04-10", "F", "HanaGhanim335@outlook.com"),
(138, "Rahma", "Salah", "55 Rod El Farag, Shobra, Cairo", "01231264870", "2011-08-18", "F", "RahmaSalah55@hotmail.com"),
(139, "Nada", "Mohamed", "86 Al Ahram, Heliopolis, Cairo", "01139465781", "1992-06-28", "F", "NadaMohamed211@hotmail.com"),
(140, "Haytham", "Nader", "82 Al Nozha, Heliopolis, Cairo", "01087023159", "2007-02-14", "M", "HaythamNader374@hotmail.com"),
(141, "Seif", "Yaser", "23 Damascus, Maadi, Cairo", "01524381096", "1996-10-05", "M", "SeifYaser51@hotmail.com"),
(142, "Rahma", "Farag", "40 Al Nozha, Heliopolis, Cairo", "01196371820", "1990-07-14", "F", "RahmaFarag243@gmail.com"),
(143, "Esraa", "Fawzi", "91 Al Khamrawaya, Shobra, Cairo", "01186475032", "1962-04-17", "F", "EsraaFawzi139@outlook.com"),
(144, "Rahma", "Farag", "9 Gamal Abdel Nasser, Al-Salam, Cairo", "01559708326", "2004-07-06", "F", "RahmaFarag92@gmail.com"),
(145, "Nourhan", "Farag", "99 Gezira, Zamalek, Cairo", "01195304621", "2010-02-26", "F", "NourhanFarag348@outlook.com"),
(146, "Aya", "Hassan", "5 26 July St, Downtown, Cairo", "01258274610", "1988-02-01", "F", "AyaHassan189@gmail.com"),
(147, "Amal", "Hassan", "83 Mamdouh Salem, Imbaba, Giza", "01150698372", "2003-03-13", "F", "AmalHassan190@outlook.com"),
(148, "Adham", "Magdy", "96 Baghdad, Heliopolis, Cairo", "01070463951", "2008-07-26", "M", "AdhamMagdy379@hotmail.com"),
(149, "Abdelrahman", "Emad", "44 Al Nahda, Maadi, Cairo", "01182159403", "1979-12-07", "M", "AbdelrahmanEmad49@hotmail.com"),
(150, "Mostafa", "Adel", "43 El Tahrir, Downtown, Cairo", "01172061384", "1995-09-16", "M", "MostafaAdel309@outlook.com"),
(151, "Hana", "Sobhi", "86 Gamal Abdel Nasser, Al-Salam, Cairo", "01137219054", "1960-01-05", "F", "HanaSobhi296@outlook.com"),
(152, "Ahmed", "Waleed", "72 Talaat Harb, Imbaba, Giza", "01145107398", "2011-11-05", "M", "AhmedWaleed327@gmail.com"),
(153, "Mahmoud", "Adel", "26 Al Kanal, Maadi, Cairo", "01006538479", "1994-06-22", "M", "MahmoudAdel136@outlook.com"),
(154, "Abdalaziz", "Sobhi", "31 Talaat Harb, Downtown, Cairo", "01593051674", "1962-11-22", "M", "AbdalazizSobhi331@hotmail.com"),
(155, "Abdalaziz", "Zakaria", "29 Hassan Assem, Zamalek, Cairo", "01232974106", "2003-12-16", "M", "AbdalazizZakaria326@gmail.com"),
(156, "Abdallah", "Hani", "90 Baghdad, Heliopolis, Cairo", "01071256038", "1981-06-26", "M", "AbdallahHani121@outlook.com"),
(157, "Amal", "Adel", "50 Shobra St., Shobra, Cairo", "01057612438", "1983-08-18", "F", "AmalAdel370@gmail.com"),
(158, "Marawan", "Ezzat", "5 Al Saad Al Aaly, Maadi, Cairo", "01570961254", "1961-02-06", "M", "MarawanEzzat372@gmail.com"),
(159, "Adham", "Ghanim", "30 Al Nadi, Maadi, Cairo", "01179630418", "2000-03-28", "M", "AdhamGhanim132@gmail.com"),
(160, "Kareem", "Ashraf", "86 Oraby, Maadi, Cairo", "01517390456", "2003-11-23", "M", "KareemAshraf54@outlook.com"),
(161, "Ali", "Nader", "29 Al Ahram, Heliopolis, Cairo", "01518936472", "1998-11-17", "M", "AliNader332@outlook.com"),
(162, "Omar", "Mohamed", "2 Al Kanal, Maadi, Cairo", "01574823169", "2014-03-21", "M", "OmarMohamed112@hotmail.com"),
(163, "Seif", "Sobhi", "16 Damascus, Maadi, Cairo", "01562987543", "1962-03-15", "M", "SeifSobhi37@gmail.com"),
(164, "Abdelrahman", "Emad", "40 Rod El Farag, Shobra, Cairo", "01525678039", "1994-03-18", "M", "AbdelrahmanEmad229@hotmail.com"),
(165, "Mohamed", "Adel", "66 Champeleon, Downtown, Cairo", "01167398041", "2006-07-06", "M", "MohamedAdel124@outlook.com"),
(166, "Nour", "Magdy", "74 28St. ,ElTahrir City, Imbaba, Giza", "01262089317", "1984-07-16", "F", "NourMagdy91@outlook.com"),
(167, "Amir", "Khaled", "75 Talaat Harb, Imbaba, Giza", "01226837915", "2008-02-07", "M", "AmirKhaled255@outlook.com"),
(168, "Ibrahim", "Sayed", "59 Al Kanal, Maadi, Cairo", "01507286319", "1990-08-18", "M", "IbrahimSayed170@hotmail.com"),
(169, "Rahma", "Sayed", "98 Al Ahram, Heliopolis, Cairo", "01030862971", "1967-09-25", "F", "RahmaSayed139@outlook.com"),
(170, "Abdalaziz", "Khaled", "21 Al Nozha, Heliopolis, Cairo", "01005687193", "1960-02-20", "M", "AbdalazizKhaled86@hotmail.com"),
(171, "Rashad", "Khalil", "28 Sherif, Downtown, Cairo", "01274189035", "2014-11-01", "M", "RashadKhalil63@outlook.com"),
(172, "Nourhan", "Khalil", "10 18St. , ElTahrir City, Imbaba, Giza", "01150673294", "1994-10-15", "F", "NourhanKhalil252@hotmail.com"),
(173, "Nour", "Fawzi", "46 Talaat Harb, Imbaba, Giza", "01520567489", "1965-10-20", "F", "NourFawzi136@hotmail.com"),
(174, "Wael", "Sobhi", "53 El Sadat, Al-Salam, Cairo", "01091048573", "2005-03-17", "M", "WaelSobhi221@gmail.com"),
(175, "Mohamed", "Fawzi", "51 Baghdad, Heliopolis, Cairo", "01565089127", "1987-07-23", "M", "MohamedFawzi314@gmail.com"),
(176, "Zeyad", "Salah", "58 Al Nadi, Maadi, Cairo", "01051496320", "1998-06-24", "M", "ZeyadSalah281@hotmail.com"),
(177, "Kareem", "Hani", "15 Taha Hussein, Zamalek, Cairo", "01284965327", "2012-08-05", "M", "KareemHani300@outlook.com"),
(178, "Mohamed", "Sobhi", "25 Shaheen, Al Doqi, Giza", "01282637094", "1974-11-22", "M", "MohamedSobhi12@hotmail.com"),
(179, "Rashad", "Adel", "9 Al Kanal, Maadi, Cairo", "01558036217", "1970-12-23", "M", "RashadAdel408@hotmail.com"),
(180, "Esraa", "Fawzi", "21 Sherif, Downtown, Cairo", "01264837125", "1984-03-21", "F", "EsraaFawzi262@outlook.com"),
(181, "Haytham", "Sobhi", "54 El Sadat, Al-Salam, Cairo", "01201849725", "1998-12-03", "M", "HaythamSobhi312@outlook.com"),
(182, "Mostafa", "Ashraf", "95 Sherif, Downtown, Cairo", "01279648150", "1971-10-14", "M", "MostafaAshraf124@outlook.com"),
(183, "Salma", "Khaled", "45 kamal Al Tawil, Zamalek, Cairo", "01051970826", "1972-06-28", "F", "SalmaKhaled115@outlook.com"),
(184, "Hager", "Zakaria", "26 18St. , ElTahrir City, Imbaba, Giza", "01519524860", "1976-01-19", "F", "HagerZakaria51@hotmail.com"),
(185, "Omnya", "Sobhi", "8 Baghdad, Heliopolis, Cairo", "01062473519", "1992-12-16", "F", "OmnyaSobhi354@gmail.com"),
(186, "Omnya", "Mohamed", "49 Mamdouh Salem, Imbaba, Giza", "01128701463", "1961-11-28", "F", "OmnyaMohamed250@hotmail.com"),
(187, "Arwa", "Magdy", "55 Taha Hussein, Zamalek, Cairo", "01505413692", "1972-08-14", "F", "ArwaMagdy377@outlook.com"),
(188, "Hager", "Zakaria", "16 Al Falaky, Downtown, Cairo", "01028304759", "1971-04-02", "F", "HagerZakaria247@outlook.com"),
(189, "Ibrahim", "Sayed", "59 Shaheen, Al Doqi, Giza", "01049530687", "1987-09-05", "M", "IbrahimSayed224@gmail.com"),
(190, "Ehab", "Sobhi", "98 Damascus, Maadi, Cairo", "01575809412", "2016-01-11", "M", "EhabSobhi147@gmail.com"),
(191, "Hager", "Ashraf", "53 El Sadat, Al-Salam, Cairo", "01075942160", "1963-11-25", "F", "HagerAshraf81@hotmail.com"),
(192, "Amal", "Sobhi", "91 Shaheen, Al Doqi, Giza", "01140913857", "2004-11-17", "F", "AmalSobhi25@outlook.com"),
(193, "Omnya", "Yaser", "62 Shaheen, Al Doqi, Giza", "01072485316", "1990-04-14", "F", "OmnyaYaser417@hotmail.com"),
(194, "Eyad", "Ashraf", "61 El Sadat, Al-Salam, Cairo", "01038749206", "1978-11-25", "M", "EyadAshraf326@gmail.com"),
(195, "Mohamed", "Khalil", "94 Al Khamrawaya, Shobra, Cairo", "01038945620", "1975-06-24", "M", "MohamedKhalil127@hotmail.com"),
(196, "Rashad", "Ashraf", "92 Shobra St., Shobra, Cairo", "01535921486", "2002-04-16", "M", "RashadAshraf130@outlook.com"),
(197, "Adham", "Yaser", "38 Ahmed Helmy, Shobra, Cairo", "01003564179", "1977-04-13", "M", "AdhamYaser103@hotmail.com"),
(198, "Esraa", "Mohamed", "57 Shaheen, Al Doqi, Giza", "01039857462", "1970-06-22", "F", "EsraaMohamed4@outlook.com"),
(199, "Noureen", "Farag", "21 Shaheen, Al Doqi, Giza", "01546937018", "1976-07-16", "F", "NoureenFarag178@hotmail.com"),
(200, "Nour", "Magdy", "51 Baghdad, Heliopolis, Cairo", "01559243876", "1970-04-11", "F", "NourMagdy25@outlook.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (115, "2010-02-15"),
(116, "2008-11-10"),
(117, "2011-06-05"),
(118, "2015-05-08"),
(119, "2009-02-15"),
(120, "2010-11-19"),
(121, "2012-11-19"),
(122, "2015-02-26"),
(123, "2011-01-07"),
(124, "2011-11-16"),
(125, "2021-02-15"),
(126, "2006-01-11"),
(127, "2008-08-24"),
(128, "2021-10-22"),
(129, "2019-07-15"),
(130, "2006-05-10"),
(131, "2022-01-24"),
(132, "2017-11-08"),
(133, "2022-01-08"),
(134, "2022-07-07"),
(135, "2009-07-06"),
(136, "2020-07-05"),
(137, "2005-12-04"),
(138, "2021-04-01"),
(139, "2021-06-16"),
(140, "2011-08-03"),
(141, "2017-05-15"),
(142, "2021-10-16"),
(143, "2015-03-27"),
(144, "2009-04-04"),
(145, "2019-08-04"),
(146, "2012-11-27"),
(147, "2020-11-25"),
(148, "2015-11-23"),
(149, "2022-07-20"),
(150, "2021-03-01"),
(151, "2015-12-01"),
(152, "2015-07-15"),
(153, "2021-02-13"),
(154, "2009-08-24"),
(155, "2006-08-08"),
(156, "2014-05-09"),
(157, "2008-10-06"),
(158, "2018-01-25"),
(159, "2021-11-01"),
(160, "2014-06-16"),
(161, "2019-08-21"),
(162, "2010-11-21"),
(163, "2007-02-04"),
(164, "2019-06-21"),
(165, "2020-03-13"),
(166, "2008-10-12"),
(167, "2022-06-12"),
(168, "2007-10-08"),
(169, "2007-06-25"),
(170, "2019-02-26"),
(171, "2018-11-12"),
(172, "2010-09-22"),
(173, "2008-08-17"),
(174, "2020-07-26"),
(175, "2010-10-17"),
(176, "2013-11-16"),
(177, "2014-01-04"),
(178, "2009-11-14"),
(179, "2017-04-22"),
(180, "2009-04-25"),
(181, "2020-03-04"),
(182, "2012-11-12"),
(183, "2005-11-28"),
(184, "2015-04-15"),
(185, "2006-10-27"),
(186, "2016-12-07"),
(187, "2018-05-28"),
(188, "2019-11-04"),
(189, "2016-01-08"),
(190, "2021-05-12"),
(191, "2015-05-02"),
(192, "2009-07-24"),
(193, "2008-10-13"),
(194, "2009-06-26"),
(195, "2021-08-07"),
(196, "2011-01-25"),
(197, "2019-10-08"),
(198, "2021-09-26"),
(199, "2020-05-04"),
(200, "2020-08-23");
INSERT INTO Management (Name, NumberOfEmployees, Manager_SSN) VALUES
("Sport",16,130),
("Events",5,135),
("Quality",5,140),
("Services",8,148),
("Board",5,149);
INSERT INTO Management_Employee (Management_Name, Employee_SSN) VALUES
("Sport",115),
("Sport",116),
("Sport",117),
("Sport",118),
("Sport",119),
("Sport",120),
("Sport",121),
("Sport",122),
("Sport",123),
("Sport",124),
("Sport",125),
("Sport",126),
("Sport",127),
("Sport",128),
("Sport",129),
("Sport",130),
("Events",131),
("Events",132),
("Events",133),
("Events",134),
("Events",135),
("Quality",136),
("Quality",137),
("Quality",138),
("Quality",139),
("Quality",140),
("Services",141),
("Services",142),
("Services",143),
("Services",144),
("Services",145),
("Services",146),
("Services",147),
("Services",148),
("Board",149),
("Board",150),
("Board",151),
("Board",152);
INSERT INTO Employee (salary,Employee_SSN) VALUES
(75000,115),
(76700,116),
(76000,117),
(78000,118),
(78900,119),
(90000,120),
(75000,121),
(75000,122),
(77400,123),
(82500,124),
(81000,125),
(77600,126),
(76000,127),
(78900,128),
(79800,129),
(76000,130),
(80000,131),
(88750,132),
(78900,133),
(84000,134),
(135000,135),
(78900,136),
(82100,137),
(81000,138),
(76800,139),
(120000,140),
(83000,141),
(78000,142),
(76700,143),
(74700,144),
(84700,145),
(86430,146),
(125000,147),
(127000,148),
(200000,149),
(188600,150),
(178000,151),
(167000,152);
