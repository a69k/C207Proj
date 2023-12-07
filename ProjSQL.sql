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
  `Player_SSN` INT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`),
  CONSTRAINT `fk_Pro_Player_Member1`
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
  `Coach_SSN` INT NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Coach_SSN`),
  CONSTRAINT `fk_Coach_person1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`person` (`SSN`)
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
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Worker_SSN`),
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`Worker_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CateringStaff_Catering_Location1`
    FOREIGN KEY (`Catering_Location` , `Catering_Name`)
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
-- Table `Club_DB`.`TeamSport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`TeamSport` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`TeamSport` (
  `Player_SSN` INT NOT NULL,
  `TeamName` VARCHAR(15) NOT NULL,
  `SportName` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Player_SSN`, `TeamName`),
  CONSTRAINT `fk_TeamSport_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
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
  PRIMARY KEY (`Player_SSN`, `Coach_SSN`),
  CONSTRAINT `fk_individualSport_Player_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_individualSport_Player_Coach1`
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


-- -----------------------------------------------------
-- Table `Club_DB`.`Pro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Pro` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Pro` (
  `Player_SSN` INT NULL,
  `Coach_SSN` INT NULL,
  `Salary` FLOAT NOT NULL,
  `ContractStart` DATE NOT NULL,
  `ContractEnd` DATE NOT NULL,
  PRIMARY KEY (`Player_SSN`, `Coach_SSN`),
  CONSTRAINT `fk_Pro_Pro_Player1`
    FOREIGN KEY (`Player_SSN`)
    REFERENCES `Club_DB`.`Pro_Player` (`Player_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pro_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
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
  PRIMARY KEY (`TeamName`, `Coach_SSN`),
  CONSTRAINT `fk_Team_Coach1`
    FOREIGN KEY (`Coach_SSN`)
    REFERENCES `Club_DB`.`Coach` (`Coach_SSN`)
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
SET FOREIGN_KEY_CHECKS=0;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (1, "Omar", "Khalil", "100 Baghdad, Heliopolis, Cairo", "01505829637", "1995-04-25", "M", "OmarKhalil93@gmail.com"),
(2, "Adham", "Nader", "73 Al Ahram, Heliopolis, Cairo", "01594360251", "2003-09-03", "M", "AdhamNader24@outlook.com"),
(3, "Sherif", "Waleed", "93 Talaat Harb, Imbaba, Giza", "01115928730", "1997-07-01", "M", "SherifWaleed333@gmail.com"),
(4, "Omar", "Sayed", "13 Al Merghany, Heliopolis, Cairo", "01257381296", "1989-02-02", "M", "OmarSayed128@hotmail.com"),
(5, "Seif", "Hani", "56 18St. , ElTahrir City, Imbaba, Giza", "01118265940", "1999-08-15", "M", "SeifHani125@gmail.com"),
(6, "Ahmed", "Khalil", "81 Al Kanal, Maadi, Cairo", "01067825309", "1997-09-14", "M", "AhmedKhalil270@outlook.com"),
(7, "Ahmed", "Khaled", "99 Al Falaky, Downtown, Cairo", "01238450269", "1987-04-15", "M", "AhmedKhaled344@gmail.com"),
(8, "Kareem", "Magdy", "68 Shagaret Al Dor, Zamalek, Cairo", "01523541068", "1998-07-14", "M", "KareemMagdy52@gmail.com"),
(9, "Eyad", "Farag", "26 Mohammed Mazhar, Zamalek, Cairo", "01062409138", "1995-01-17", "M", "EyadFarag321@outlook.com"),
(10, "Mohamed", "Sayed", "100 Mamdouh Salem, Imbaba, Giza", "01245712360", "2003-12-28", "M", "MohamedSayed152@gmail.com"),
(11, "Mohamed", "Ghanim", "75 El Sadat, Al-Salam, Cairo", "01571342958", "1987-08-27", "M", "MohamedGhanim346@gmail.com"),
(12, "Mostafa", "Fawzi", "100 Taha Hussein, Zamalek, Cairo", "01175386940", "1989-09-10", "M", "MostafaFawzi140@hotmail.com"),
(13, "Mahmoud", "Yaser", "7 Talaat Harb, Downtown, Cairo", "01564021578", "2002-06-10", "M", "MahmoudYaser88@outlook.com"),
(14, "Haytham", "Zakaria", "46 Hassan Sabry, Zamalek, Cairo", "01249871625", "1998-04-15", "M", "HaythamZakaria134@outlook.com"),
(15, "Adham", "Ghanim", "94 Adly, Downtown, Cairo", "01137129058", "2001-03-24", "M", "AdhamGhanim152@outlook.com"),
(16, "Yousif", "Ezzat", "67 Gad Eid, Al Doqi, Giza", "01274802935", "1987-02-06", "M", "YousifEzzat101@outlook.com"),
(17, "Abdallah", "Magdy", "33 Damascus, Maadi, Cairo", "01086135042", "1987-04-04", "M", "AbdallahMagdy396@hotmail.com"),
(18, "Seif", "Khaled", "77 Talaat Harb, Downtown, Cairo", "01207985142", "1994-08-01", "M", "SeifKhaled59@hotmail.com"),
(19, "Mohamed", "Nader", "51 Al Hegaz, Heliopolis, Cairo", "01179584362", "1995-05-03", "M", "MohamedNader219@outlook.com"),
(20, "Seif", "Ashraf", "2 Talaat Harb, Imbaba, Giza", "01528015439", "1996-02-15", "M", "SeifAshraf82@gmail.com"),
(21, "Ahmed", "Fawzi", "10 Salah El Din, Heliopolis, Cairo", "01175031864", "1997-12-28", "M", "AhmedFawzi239@outlook.com"),
(22, "Ahmed", "Ezzat", "28 Doletyan, Shobra, Cairo", "01559420381", "2002-06-27", "M", "AhmedEzzat130@outlook.com"),
(23, "Ali", "Hani", "81 Rod El Farag, Shobra, Cairo", "01257328016", "1995-11-27", "M", "AliHani162@gmail.com"),
(24, "Kareem", "Ghanim", "6 Rod El Farag, Shobra, Cairo", "01575941280", "1992-11-22", "M", "KareemGhanim103@hotmail.com"),
(25, "Zeyad", "Fawzi", "35 Gad Eid, Al Doqi, Giza", "01230265174", "1992-01-26", "M", "ZeyadFawzi398@hotmail.com"),
(26, "Abdelrahman", "Ashraf", "8 Ahmed Helmy, Shobra, Cairo", "01047128036", "1994-10-10", "M", "AbdelrahmanAshraf24@hotmail.com"),
(27, "Zeyad", "Mohamed", "34 El Sadat, Al-Salam, Cairo", "01198024653", "1994-10-26", "M", "ZeyadMohamed244@gmail.com"),
(28, "Amir", "Yaser", "16 Rod El Farag, Shobra, Cairo", "01287093125", "1998-07-11", "M", "AmirYaser98@gmail.com"),
(29, "Omar", "Fawzi", "44 Kholousi, Shobra, Cairo", "01219428306", "1994-12-13", "M", "OmarFawzi192@gmail.com"),
(30, "Ahmed", "Fawzi", "63 Salah El Din, Heliopolis, Cairo", "01098574103", "1992-09-21", "M", "AhmedFawzi362@hotmail.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (1, "2022-02-05"),
(2, "2022-02-07"),
(3, "2020-01-23"),
(4, "2022-04-21"),
(5, "2022-11-28"),
(6, "2022-03-05"),
(7, "2021-06-25"),
(8, "2022-05-12"),
(9, "2021-06-21"),
(10, "2022-11-11"),
(11, "2021-03-08"),
(12, "2021-04-17"),
(13, "2021-05-06"),
(14, "2020-05-05"),
(15, "2021-05-01"),
(16, "2021-12-14"),
(17, "2020-11-25"),
(18, "2022-09-23"),
(19, "2021-04-28"),
(20, "2020-05-12"),
(21, "2021-05-02"),
(22, "2021-05-08"),
(23, "2022-05-25"),
(24, "2022-01-27"),
(25, "2022-09-22"),
(26, "2022-06-27"),
(27, "2022-08-17"),
(28, "2022-04-17"),
(29, "2021-10-08"),
(30, "2021-09-25");
INSERT INTO Pro_Player (Player_SSN, SportName) VALUES
(1,'Football'),
(2,'Football'),
(3,'Football'),
(4,'Football'),
(5,'Football'),
(6,'Football'),
(7,'Football'),
(8,'Football'),
(9,'Football'),
(10,'Football'),
(11,'Football'),
(12,'Football'),
(13,'Football'),
(14,'Football'),
(15,'Football'),
(16,'Football'),
(17,'Football'),
(18,'Football'),
(19,'Football'),
(20,'Football'),
(21,'Football'),
(22,'Football'),
(23,'Football'),
(24,'Football'),
(25,'Football'),
(26,'Football'),
(27,'Football'),
(28,'Football'),
(29,'Football'),
(30,'Football');
INSERT INTO TeamSport_Player (Player_SSN, SportName, TeamName) VALUES
(1,"Football", "First Team"),
(2,"Football", "First Team"),
(3,"Football", "First Team"),
(4,"Football", "First Team"),
(5,"Football", "First Team"),
(6,"Football", "First Team"),
(7,"Football", "First Team"),
(8,"Football", "First Team"),
(9,"Football", "First Team"),
(10,"Football", "First Team"),
(11,"Football", "First Team"),
(12,"Football", "First Team"),
(13,"Football", "First Team"),
(14,"Football", "First Team"),
(15,"Football", "First Team"),
(16,"Football", "First Team"),
(17,"Football", "First Team"),
(18,"Football", "First Team"),
(19,"Football", "First Team"),
(20,"Football", "First Team"),
(21,"Football", "First Team"),
(22,"Football", "First Team"),
(23,"Football", "First Team"),
(24,"Football", "First Team"),
(25,"Football", "First Team"),
(26,"Football", "First Team"),
(27,"Football", "First Team"),
(28,"Football", "First Team"),
(29,"Football", "First Team"),
(30,"Football", "First Team");

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(31, "Mohamed", "Hani", "34 28St. ,ElTahrir City, Imbaba, Giza", "01030178425", "2005-09-14", "M", "MohamedHani129@outlook.com"),
(32, "Zeyad", "Yaser", "40 18St. , ElTahrir City, Imbaba, Giza", "01102374158", "2005-07-20", "M", "ZeyadYaser356@hotmail.com"),
(33, "Seif", "Magdy", "50 Shaheen, Al Doqi, Giza", "01149832615", "2007-05-24", "M", "SeifMagdy359@hotmail.com"),
(34, "Ehab", "Waleed", "44 28St. ,ElTahrir City, Imbaba, Giza", "01016289075", "2006-12-23", "M", "EhabWaleed339@outlook.com"),
(35, "Abdallah", "Farag", "54 Gamal Abdel Nasser, Al-Salam, Cairo", "01245198607", "2007-08-20", "M", "AbdallahFarag128@hotmail.com"),
(36, "Amr", "Ashraf", "77 Hassan Ramadan, Al Doqi, Giza", "01507639154", "2007-02-18", "M", "AmrAshraf272@gmail.com"),
(37, "Abdallah", "Yaser", "74 Taha Hussein, Zamalek, Cairo", "01505397412", "2007-04-15", "M", "AbdallahYaser291@hotmail.com"),
(38, "Wael", "Khaled", "62 26 July St, Downtown, Cairo", "01241683907", "2005-06-18", "M", "WaelKhaled403@hotmail.com"),
(39, "Yousif", "Magdy", "58 Talaat Harb, Imbaba, Giza", "01153297064", "2007-08-23", "M", "YousifMagdy139@gmail.com"),
(40, "Abdalaziz", "Khalil", "42 Bahgat Ali, Zamalek, Cairo", "01152193076", "2007-08-07", "M", "AbdalazizKhalil67@hotmail.com"),
(41, "Eyad", "Salah", "46 Gamal Abdel Nasser, Al-Salam, Cairo", "01150762139", "2008-02-15", "M", "EyadSalah153@outlook.com"),
(42, "Adham", "Zakaria", "24 Shaheen, Al Doqi, Giza", "01137492185", "2005-11-04", "M", "AdhamZakaria139@gmail.com"),
(43, "Mahmoud", "Salah", "33 Taha Hussein, Zamalek, Cairo", "01584035912", "2006-06-24", "M", "MahmoudSalah9@hotmail.com"),
(44, "Ibrahim", "Emad", "3 Al Merghany, Heliopolis, Cairo", "01152730861", "2005-03-09", "M", "IbrahimEmad331@outlook.com"),
(45, "Mohamed", "Khaled", "27 Al Kanal, Maadi, Cairo", "01018963524", "2007-03-14", "M", "MohamedKhaled122@outlook.com"),
(46, "Yousif", "Ashraf", "86 Hassan Ramadan, Al Doqi, Giza", "01249713826", "2007-02-23", "M", "YousifAshraf61@outlook.com"),
(47, "Haytham", "Hassan", "77 Sherif, Downtown, Cairo", "01150176382", "2007-01-11", "M", "HaythamHassan103@gmail.com"),
(48, "Eyad", "Hani", "100 28St. ,ElTahrir City, Imbaba, Giza", "01235081479", "2007-01-05", "M", "EyadHani210@outlook.com"),
(49, "Amr", "Farag", "88 Gamal Abdel Nasser, Al-Salam, Cairo", "01093281057", "2008-06-21", "M", "AmrFarag253@gmail.com"),
(50, "Abdallah", "Mohamed", "67 Al Teraa Al Boulakeya, Shobra, Cairo", "01578546120", "2008-11-03", "M", "AbdallahMohamed184@hotmail.com"),
(51, "Rashad", "Khaled", "8 Shaheen, Al Doqi, Giza", "01589041623", "2008-05-26", "M", "RashadKhaled353@outlook.com"),
(52, "Mahmoud", "Sayed", "17 Kholousi, Shobra, Cairo", "01225807169", "2006-08-18", "M", "MahmoudSayed22@gmail.com"),
(53, "Haytham", "Magdy", "87 Salah El Din, Heliopolis, Cairo", "01292830175", "2007-05-23", "M", "HaythamMagdy46@hotmail.com"),
(54, "Eyad", "Zakaria", "90 Gamal Abdel Nasser, Al-Salam, Cairo", "01090572483", "2005-09-14", "M", "EyadZakaria299@gmail.com"),
(55, "Rashad", "Fawzi", "12 Talaat Harb, Imbaba, Giza", "01171643928", "2008-01-11", "M", "RashadFawzi172@gmail.com"),
(56, "Zeyad", "Salah", "71 Rod El Farag, Shobra, Cairo", "01147951082", "2007-08-17", "M", "ZeyadSalah180@outlook.com"),
(57, "Ibrahim", "Fawzi", "94 Baghdad, Heliopolis, Cairo", "01087302169", "2008-10-17", "M", "IbrahimFawzi217@outlook.com"),
(58, "Amir", "Sayed", "74 Talaat Harb, Imbaba, Giza", "01081945036", "2006-07-13", "M", "AmirSayed140@hotmail.com"),
(59, "Ibrahim", "Ashraf", "11 El Tahrir, Downtown, Cairo", "01126408931", "2005-11-13", "M", "IbrahimAshraf175@gmail.com"),
(60, "Amr", "Farag", "63 Taha Hussein, Zamalek, Cairo", "01007695183", "2005-11-24", "M", "AmrFarag116@hotmail.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (31, "2021-06-01"),
(32, "2021-02-08"),
(33, "2022-04-16"),
(34, "2022-04-28"),
(35, "2020-09-03"),
(36, "2020-06-04"),
(37, "2022-10-17"),
(38, "2022-05-25"),
(39, "2020-03-13"),
(40, "2022-03-04"),
(41, "2021-08-11"),
(42, "2021-04-26"),
(43, "2020-06-01"),
(44, "2022-04-24"),
(45, "2022-08-21"),
(46, "2022-12-19"),
(47, "2020-01-18"),
(48, "2022-12-10"),
(49, "2020-11-24"),
(50, "2021-03-24"),
(51, "2021-08-02"),
(52, "2022-09-10"),
(53, "2020-09-18"),
(54, "2021-01-14"),
(55, "2021-06-12"),
(56, "2022-02-10"),
(57, "2022-02-01"),
(58, "2021-02-11"),
(59, "2021-05-27"),
(60, "2020-05-24");
INSERT INTO Pro_Player (Player_SSN, SportName) VALUES
 (31,'Football'),
(32,'Football'),
(33,'Football'),
(34,'Football'),
(35,'Football'),
(36,'Football'),
(37,'Football'),
(38,'Football'),
(39,'Football'),
(40,'Football'),
(41,'Football'),
(42,'Football'),
(43,'Football'),
(44,'Football'),
(45,'Football'),
(46,'Football'),
(47,'Football'),
(48,'Football'),
(49,'Football'),
(50,'Football'),
(51,'Football'),
(52,'Football'),
(53,'Football'),
(54,'Football'),
(55,'Football'),
(56,'Football'),
(57,'Football'),
(58,'Football'),
(59,'Football'),
(60,'Football');
INSERT INTO TeamSport_Player (Player_SSN, SportName, TeamName) VALUES
 (31,"Football", "Academy Team"),
(32,"Football", "Academy Team"),
(33,"Football", "Academy Team"),
(34,"Football", "Academy Team"),
(35,"Football", "Academy Team"),
(36,"Football", "Academy Team"),
(37,"Football", "Academy Team"),
(38,"Football", "Academy Team"),
(39,"Football", "Academy Team"),
(40,"Football", "Academy Team"),
(41,"Football", "Academy Team"),
(42,"Football", "Academy Team"),
(43,"Football", "Academy Team"),
(44,"Football", "Academy Team"),
(45,"Football", "Academy Team"),
(46,"Football", "Academy Team"),
(47,"Football", "Academy Team"),
(48,"Football", "Academy Team"),
(49,"Football", "Academy Team"),
(50,"Football", "Academy Team"),
(51,"Football", "Academy Team"),
(52,"Football", "Academy Team"),
(53,"Football", "Academy Team"),
(54,"Football", "Academy Team"),
(55,"Football", "Academy Team"),
(56,"Football", "Academy Team"),
(57,"Football", "Academy Team"),
(58,"Football", "Academy Team"),
(59,"Football", "Academy Team"),
(60,"Football", "Academy Team");

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(61, "Rashad", "Sayed", "65 Kholousi, Shobra, Cairo", "01119276584", "1999-12-06", "M", "RashadSayed177@outlook.com"),
(62, "Haytham", "Nader", "19 Hassan Ramadan, Al Doqi, Giza", "01257160239", "2002-05-16", "M", "HaythamNader105@gmail.com"),
(63, "Sherif", "Hani", "4 Mamdouh Salem, Imbaba, Giza", "01126018379", "1999-10-09", "M", "SherifHani303@gmail.com"),
(64, "Sherif", "Khaled", "53 Al Saad Al Aaly, Maadi, Cairo", "01131765240", "1995-01-09", "M", "SherifKhaled57@gmail.com"),
(65, "Omar", "Sobhi", "46 Taha Hussein, Zamalek, Cairo", "01549512830", "1993-10-22", "M", "OmarSobhi152@outlook.com"),
(66, "Kareem", "Farag", "98 26 July St, Downtown, Cairo", "01517486923", "1994-12-22", "M", "KareemFarag230@outlook.com"),
(67, "Ibrahim", "Khaled", "83 Adly, Downtown, Cairo", "01528741963", "1994-11-11", "M", "IbrahimKhaled75@hotmail.com"),
(68, "Eyad", "Sobhi", "73 Abou El Feda, Zamalek, Cairo", "01224063981", "1996-03-01", "M", "EyadSobhi407@gmail.com"),
(69, "Haytham", "Zakaria", "77 Gamal Abdel Nasser, Al-Salam, Cairo", "01197240631", "1992-10-17", "M", "HaythamZakaria59@hotmail.com"),
(70, "Rashad", "Nader", "58 Al Ahram, Heliopolis, Cairo", "01505493216", "1994-01-24", "M", "RashadNader339@outlook.com"),
(71, "Seif", "Mohamed", "16 26 July St, Downtown, Cairo", "01128176935", "2000-04-10", "M", "SeifMohamed292@outlook.com"),
(72, "Seif", "Sobhi", "79 kamal Al Tawil, Zamalek, Cairo", "01208932671", "2001-10-22", "M", "SeifSobhi298@gmail.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (61, "2020-10-03"),
(62, "2021-08-17"),
(63, "2020-07-24"),
(64, "2022-02-20"),
(65, "2022-09-24"),
(66, "2021-10-19"),
(67, "2022-08-19"),
(68, "2022-11-03"),
(69, "2021-06-10"),
(70, "2020-03-08"),
(71, "2021-11-16"),
(72, "2021-08-21");
INSERT INTO Pro_Player (Player_SSN, SportName) VALUES
 (61,'Basketball'),
(62,'Basketball'),
(63,'Basketball'),
(64,'Basketball'),
(65,'Basketball'),
(66,'Basketball'),
(67,'Basketball'),
(68,'Basketball'),
(69,'Basketball'),
(70,'Basketball'),
(71,'Basketball'),
(72,'Basketball');
INSERT INTO TeamSport_Player (Player_SSN, SportName, TeamName) VALUES
(61,"Basketball", "Mens Team"),
(62,"Basketball", "Mens Team"),
(63,"Basketball", "Mens Team"),
(64,"Basketball", "Mens Team"),
(65,"Basketball", "Mens Team"),
(66,"Basketball", "Mens Team"),
(67,"Basketball", "Mens Team"),
(68,"Basketball", "Mens Team"),
(69,"Basketball", "Mens Team"),
(70,"Basketball", "Mens Team"),
(71,"Basketball", "Mens Team"),
(72,"Basketball", "Mens Team");

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (73, "Yasmin", "Hassan", "92 Champeleon, Downtown, Cairo", "01212963458", "2002-03-22", "F", "YasminHassan380@gmail.com"),
(74, "Salma", "Khalil", "13 Gamal Abdel Nasser, Al-Salam, Cairo", "01198345027", "1995-01-27", "F", "SalmaKhalil71@hotmail.com"),
(75, "Hana", "Magdy", "80 Bahgat Ali, Zamalek, Cairo", "01297056842", "1996-11-26", "F", "HanaMagdy330@outlook.com"),
(76, "Esraa", "Ezzat", "27 Gad Eid, Al Doqi, Giza", "01065317249", "2001-03-04", "F", "EsraaEzzat135@hotmail.com"),
(77, "Aya", "Mohamed", "50 Gamal Abdel Nasser, Al-Salam, Cairo", "01221740893", "1991-04-07", "F", "AyaMohamed24@gmail.com"),
(78, "Nour", "Ghanim", "10 Mamdouh Salem, Imbaba, Giza", "01214928753", "1994-03-06", "F", "NourGhanim311@gmail.com"),
(79, "Yasmin", "Hassan", "23 Oraby, Maadi, Cairo", "01150391872", "1995-12-16", "F", "YasminHassan415@outlook.com"),
(80, "Amal", "Khaled", "27 Shaheen, Al Doqi, Giza", "01061237485", "1991-03-24", "F", "AmalKhaled402@gmail.com"),
(81, "Amani", "Waleed", "92 Al Ahram, Heliopolis, Cairo", "01219273548", "1997-07-14", "F", "AmaniWaleed196@gmail.com"),
(82, "Arwa", "Khalil", "9 Gamal Abdel Nasser, Al-Salam, Cairo", "01175423906", "1998-04-11", "F", "ArwaKhalil403@gmail.com"),
(83, "Omnya", "Khaled", "7 Al Merghany, Heliopolis, Cairo", "01029730458", "1996-05-01", "F", "OmnyaKhaled318@gmail.com"),
(84, "Rahma", "Sobhi", "92 Mamdouh Salem, Imbaba, Giza", "01523571648", "1998-03-27", "F", "RahmaSobhi212@outlook.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (73, "2022-05-27"),
(74, "2020-08-24"),
(75, "2021-06-03"),
(76, "2020-09-02"),
(77, "2022-12-10"),
(78, "2021-10-19"),
(79, "2020-09-20"),
(80, "2020-02-14"),
(81, "2020-09-17"),
(82, "2021-05-07"),
(83, "2020-07-26"),
(84, "2021-01-27");
INSERT INTO Pro_Player (Player_SSN, SportName) VALUES
 (73,'Basketball'),
(74,'Basketball'),
(75,'Basketball'),
(76,'Basketball'),
(77,'Basketball'),
(78,'Basketball'),
(79,'Basketball'),
(80,'Basketball'),
(81,'Basketball'),
(82,'Basketball'),
(83,'Basketball'),
(84,'Basketball');
INSERT INTO TeamSport_Player (Player_SSN, SportName, TeamName) VALUES
(73,"Basketball", "Womens Team"),
(74,"Basketball", "Womens Team"),
(75,"Basketball", "Womens Team"),
(76,"Basketball", "Womens Team"),
(77,"Basketball", "Womens Team"),
(78,"Basketball", "Womens Team"),
(79,"Basketball", "Womens Team"),
(80,"Basketball", "Womens Team"),
(81,"Basketball", "Womens Team"),
(82,"Basketball", "Womens Team"),
(83,"Basketball", "Womens Team"),
(84,"Basketball", "Womens Team");

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(85, "Salma", "Salah", "65 26 July St, Downtown, Cairo", "01521548936", "2002-01-02", "F", "SalmaSalah286@outlook.com"),
(86, "Salma", "Khaled", "53 Kholousi, Shobra, Cairo", "01273980156", "2004-03-17", "F", "SalmaKhaled5@outlook.com"),
(87, "Mostafa", "Sobhi", "24 Doletyan, Shobra, Cairo", "01539218046", "2001-11-15", "M", "MostafaSobhi199@outlook.com"),
(88, "Toaa", "Hani", "20 Hassan Sabry, Zamalek, Cairo", "01217398620", "2000-01-24", "F", "ToaaHani357@gmail.com"),
(89, "Yasmin", "Fawzi", "74 Salah El Din, Heliopolis, Cairo", "01208473291", "2000-09-16", "F", "YasminFawzi13@gmail.com"),
(90, "Mostafa", "Khalil", "61 Salah El Din, Heliopolis, Cairo", "01564973102", "2001-08-10", "M", "MostafaKhalil107@outlook.com"),
(91, "Yasmin", "Nader", "91 151 St., Maadi, Cairo", "01230586724", "1998-01-27", "F", "YasminNader230@hotmail.com"),
(92, "Ibrahim", "Adel", "92 Bahgat Ali, Zamalek, Cairo", "01296273105", "2001-10-16", "M", "IbrahimAdel20@hotmail.com"),
(93, "Abdallah", "Zakaria", "19 Shaheen, Al Doqi, Giza", "01597628104", "2003-09-01", "M", "AbdallahZakaria401@outlook.com"),
(94, "Ahmed", "Khalil", "42 18St. , ElTahrir City, Imbaba, Giza", "01196237450", "1994-08-16", "M", "AhmedKhalil52@outlook.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
(85, "2022-03-23"),
(86, "2021-06-21"),
(87, "2016-06-19"),
(88, "2019-07-28"),
(89, "2018-08-18"),
(90, "2021-12-10"),
(91, "2019-03-05"),
(92, "2022-03-12"),
(93, "2015-03-12"),
(94, "2019-04-06");
INSERT INTO Pro_Player (Player_SSN, SportName) VALUES
(85, 'Swimming'),
(86, 'Swimming'),
(87, 'Swimming'),
(88, 'Swimming'),
(89, 'Swimming'),
(90, 'Swimming'),
(91, 'Swimming'),
(92, 'Swimming'),
(93, 'Swimming'),
(94, 'Swimming');

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
 (95, "Amani", "Emad", "25 Al Merghany, Heliopolis, Cairo", "01145701892", "2002-07-19", "F", "AmaniEmad90@hotmail.com"),
(96, "Noureen", "Nader", "15 Bahgat Ali, Zamalek, Cairo", "01152803697", "1998-09-27", "F", "NoureenNader296@hotmail.com"),
(97, "Rahma", "Yaser", "95 Al Kanal, Maadi, Cairo", "01143586219", "2001-12-05", "F", "RahmaYaser232@gmail.com"),
(98, "Amal", "Nader", "5 Shaheen, Al Doqi, Giza", "01596873520", "1999-07-06", "F", "AmalNader414@hotmail.com"),
(99, "Ehab", "Zakaria", "60 El Sadat, Al-Salam, Cairo", "01582017354", "2001-04-08", "M", "EhabZakaria23@hotmail.com"),
(100, "Ahmed", "Ashraf", "66 Gezira, Zamalek, Cairo", "01128461309", "1995-07-26", "M", "AhmedAshraf46@gmail.com"),
(101, "Salma", "Khalil", "72 Al Hegaz, Heliopolis, Cairo", "01061924078", "2000-02-21", "F", "SalmaKhalil177@gmail.com"),
(102, "Yousif", "Ezzat", "53 Kholousi, Shobra, Cairo", "01573812965", "1999-05-06", "M", "YousifEzzat383@gmail.com"),
(103, "Ali", "Salah", "42 Talaat Harb, Imbaba, Giza", "01069183740", "1995-04-05", "M", "AliSalah71@hotmail.com"),
(104, "Noureen", "Ashraf", "91 Al Nozha, Heliopolis, Cairo", "01010359476", "1994-09-09", "F", "NoureenAshraf331@outlook.com");
INSERT INTO member (Member_SSN, MembershipStartDate) VALUES
 (95, "2016-12-10"),
(96, "2023-06-09"),
(97, "2015-06-19"),
(98, "2018-08-01"),
(99, "2017-12-27"),
(100, "2021-02-26"),
(101, "2019-06-26"),
(102, "2021-02-16"),
(103, "2022-02-27"),
(104, "2023-10-07");
INSERT INTO Pro_Player (Player_SSN, SportName) VALUES
 (95, 'Kung Fu'),
(96, 'Kung Fu'),
(97, 'Kung Fu'),
(98, 'Kung Fu'),
(99, 'Kung Fu'),
(100, 'Kung Fu'),
(101, 'Kung Fu'),
(102, 'Kung Fu'),
(103, 'Kung Fu'),
(104, 'Kung Fu');

INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(105, 'Yousif', 'Emad', '93 Champeleon, Downtown, Cairo', '01169247835', '1985-03-11', 'M', 'YousifEmad138@hotmail.com'),
(106, 'Eyad', 'Fawzi', '53 Damascus, Maadi, Cairo', '01138452016', '1976-03-04', 'M', 'EyadFawzi146@outlook.com'),
(107, 'Abdalaziz', 'Zakaria', '62 Al Hegaz, Heliopolis, Cairo', '01132159408', '1962-01-17', 'M', 'AbdalazizZakaria375@gmail.com'),
(108, 'Ali', 'Mohamed', '5 Talaat Harb, Imbaba, Giza', '01129463781', '1967-05-19', 'M', 'AliMohamed256@gmail.com'),
(109, 'Kareem', 'Sobhi', '92 Ahmed Helmy, Shobra, Cairo', '01164875392', '1985-04-24', 'M', 'KareemSobhi162@gmail.com'),
(110, 'Abdallah', 'Khaled', '17 Shagaret Al Dor, Zamalek, Cairo', '01296812375', '1978-02-15', 'M', 'AbdallahKhaled113@hotmail.com'),
(111, 'Ehab', 'Khaled', '57 Mamdouh Salem, Imbaba, Giza', '01198410573', '1962-11-26', 'M', 'EhabKhaled379@outlook.com'),
(112, 'Amr', 'Adel', '70 9 St., Maadi, Cairo', '01513249768', '1985-07-19', 'M', 'AmrAdel89@gmail.com'),
(113, 'Wael', 'Khalil', '65 Hassan Sabry, Zamalek, Cairo', '01016725398', '1984-03-21', 'M', 'WaelKhalil88@outlook.com'),
(114, 'Yousif', 'Yaser', '83 Talaat Harb, Imbaba, Giza', '01245380216', '1964-07-01', 'M', 'YousifYaser110@outlook.com');
INSERT INTO Coach (Coach_SSN, SportName) VALUES
(105, 'Football'),
(106, 'Football'),
(107, 'Basketball'),
(108, 'Basketball'),
(109, 'Swimming'),
(110, 'Swimming'),
(111, 'Swimming'),
(112, 'Kung Fu'),
(113, 'Kung Fu'),
(114, 'Kung Fu');

INSERT INTO Team (TeamName,Coach_SSN) VALUES 
('First Team', 105),
('Academy Team',106),
('Mens Team', 107),
('Womens Team',108);

INSERT INTO individualSport_Player (Player_SSN,Coach_SSN) VALUES
(85,109),
(86,109),
(87,109),
(88,109),
(89,110),
(90,110),
(91,110),
(92,111),
(93,111),
(94,111),
(95,112),
(96,112),
(97,112),
(98,112),
(99,113),
(100,113),
(101,113),
(102,114),
(103,114),
(104,114);

INSERT INTO Pro (Player_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
 (1, 'Sport', 409916, '2022-03-03', '2025-06-23'),
(2, 'Sport', 282056, '2021-08-05', '2025-10-02'),
(3, 'Sport', 422345, '2020-10-04', '2024-01-12'),
(4, 'Sport', 424615, '2023-12-05', '2026-10-27'),
(5, 'Sport', 426611, '2020-10-05', '2026-04-18'),
(6, 'Sport', 373424, '2022-07-06', '2024-06-14'),
(7, 'Sport', 213697, '2020-01-05', '2025-12-06'),
(8, 'Sport', 292068, '2023-06-03', '2026-03-12'),
(9, 'Sport', 415439, '2023-05-01', '2024-05-03'),
(10, 'Sport', 433134, '2022-08-03', '2025-09-17'),
(11, 'Sport', 201077, '2020-05-06', '2024-08-11'),
(12, 'Sport', 338020, '2022-09-05', '2026-12-14'),
(13, 'Sport', 339133, '2023-06-01', '2024-06-23'),
(14, 'Sport', 210788, '2022-08-01', '2025-07-24'),
(15, 'Sport', 276596, '2020-06-01', '2025-10-24'),
(16, 'Sport', 385569, '2022-11-05', '2025-08-04'),
(17, 'Sport', 337675, '2023-09-04', '2026-08-26'),
(18, 'Sport', 336118, '2022-07-06', '2024-05-13'),
(19, 'Sport', 363535, '2021-07-03', '2025-01-03'),
(20, 'Sport', 374058, '2022-07-04', '2025-04-08'),
(21, 'Sport', 219003, '2022-09-01', '2025-03-22'),
(22, 'Sport', 281909, '2022-10-02', '2025-07-01'),
(23, 'Sport', 329828, '2022-08-05', '2026-08-16'),
(24, 'Sport', 352318, '2020-05-03', '2024-12-23'),
(25, 'Sport', 276201, '2020-11-02', '2025-07-25'),
(26, 'Sport', 361562, '2021-08-03', '2025-10-23'),
(27, 'Sport', 225535, '2022-11-05', '2024-07-25'),
(28, 'Sport', 262794, '2022-08-05', '2026-05-27'),
(29, 'Sport', 311242, '2023-08-04', '2024-08-02'),
(30, 'Sport', 399745, '2021-01-02', '2024-11-11');
INSERT INTO Pro (Player_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
 (31, 'Sport', 105811, '2020-02-02', '2025-03-02'),
(32, 'Sport', 97601, '2021-10-04', '2026-02-13'),
(33, 'Sport', 81436, '2020-06-03', '2024-12-15'),
(34, 'Sport', 105298, '2023-02-03', '2026-08-18'),
(35, 'Sport', 102287, '2020-10-04', '2024-05-27'),
(36, 'Sport', 78836, '2020-01-06', '2024-05-02'),
(37, 'Sport', 98450, '2022-11-03', '2025-12-10'),
(38, 'Sport', 81671, '2023-12-04', '2024-12-18'),
(39, 'Sport', 118825, '2023-04-03', '2025-04-22'),
(40, 'Sport', 86308, '2021-12-01', '2025-12-22'),
(41, 'Sport', 116795, '2023-05-01', '2024-04-18'),
(42, 'Sport', 95344, '2022-01-06', '2025-11-16'),
(43, 'Sport', 91095, '2023-07-05', '2024-01-16'),
(44, 'Sport', 108190, '2020-12-05', '2026-04-25'),
(45, 'Sport', 70694, '2022-09-05', '2024-07-07'),
(46, 'Sport', 88180, '2020-01-03', '2024-01-08'),
(47, 'Sport', 96955, '2022-12-05', '2024-12-16'),
(48, 'Sport', 77265, '2020-08-01', '2024-04-25'),
(49, 'Sport', 93806, '2021-06-06', '2025-04-28'),
(50, 'Sport', 80436, '2020-06-02', '2024-10-07'),
(51, 'Sport', 107698, '2023-09-05', '2025-10-08'),
(52, 'Sport', 110310, '2023-04-06', '2026-01-10'),
(53, 'Sport', 98607, '2023-05-04', '2024-09-19'),
(54, 'Sport', 111771, '2023-10-04', '2024-11-11'),
(55, 'Sport', 103267, '2023-03-02', '2025-03-10'),
(56, 'Sport', 93545, '2022-09-05', '2026-11-27'),
(57, 'Sport', 110463, '2020-07-01', '2026-10-13'),
(58, 'Sport', 99769, '2023-05-03', '2026-09-20'),
(59, 'Sport', 104945, '2023-11-04', '2026-06-20'),
(60, 'Sport', 117627, '2022-01-04', '2025-08-15');
INSERT INTO Pro (Player_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
(61, 'Sport', 155605, '2020-03-06', '2026-01-07'),
(62, 'Sport', 162287, '2021-04-05', '2026-03-23'),
(63, 'Sport', 166569, '2021-09-06', '2024-04-08'),
(64, 'Sport', 164241, '2021-04-03', '2025-05-01'),
(65, 'Sport', 218288, '2020-07-04', '2024-10-07'),
(66, 'Sport', 150341, '2021-09-04', '2024-07-08'),
(67, 'Sport', 188940, '2020-04-04', '2024-07-26'),
(68, 'Sport', 226256, '2020-06-06', '2026-02-06'),
(69, 'Sport', 137371, '2022-01-06', '2026-10-01'),
(70, 'Sport', 149819, '2022-09-04', '2026-03-16'),
(71, 'Sport', 142645, '2023-02-01', '2024-09-13'),
(72, 'Sport', 197347, '2021-05-05', '2025-12-01');
INSERT INTO Pro (Player_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
(73, 'Sport', 144013, '2023-07-02', '2024-04-28'),
(74, 'Sport', 117309, '2022-12-02', '2024-03-25'),
(75, 'Sport', 135298, '2022-12-06', '2024-07-03'),
(76, 'Sport', 135253, '2022-12-02', '2026-07-13'),
(77, 'Sport', 114414, '2022-05-03', '2025-01-17'),
(78, 'Sport', 121816, '2023-05-06', '2026-04-21'),
(79, 'Sport', 124189, '2023-12-04', '2026-01-04'),
(80, 'Sport', 116771, '2022-02-05', '2025-02-07'),
(81, 'Sport', 144058, '2023-08-05', '2025-05-02'),
(82, 'Sport', 134779, '2023-12-01', '2024-10-03'),
(83, 'Sport', 130349, '2022-10-06', '2026-12-17'),
(84, 'Sport', 119109, '2022-07-05', '2025-06-22');
INSERT INTO Pro (Player_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
(85, 'Sport', 156526, '2023-09-06', '2024-11-20'),
(86, 'Sport', 138367, '2023-10-01', '2026-03-23'),
(87, 'Sport', 140162, '2022-02-06', '2025-11-07'),
(88, 'Sport', 145097, '2022-11-03', '2026-01-09'),
(89, 'Sport', 127079, '2022-01-05', '2025-06-13'),
(90, 'Sport', 123290, '2023-03-03', '2026-08-10'),
(91, 'Sport', 159542, '2023-11-05', '2025-07-07'),
(92, 'Sport', 149449, '2022-04-01', '2026-04-09'),
(93, 'Sport', 122025, '2022-12-04', '2025-02-20'),
(94, 'Sport', 158108, '2022-03-02', '2026-08-19');
INSERT INTO Pro (Player_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
(95,"Sport",101586,"2022-03-05","2024-07-03"),
(96,"Sport",91671,"2022-07-04","2025-03-18"),
(97,"Sport",91071,"2023-11-06","2025-01-11"),
(98,"Sport",112574,"2022-09-06","2024-02-09"),
(99,"Sport",95913,"2022-12-03","2025-08-26"),
(100,"Sport",104142,"2022-10-03","2026-07-07"),
(101,"Sport",104972,"2023-06-02","2024-01-19"),
(102,"Sport",91490,"2023-06-03","2025-04-18"),
(103,"Sport",99797,"2022-03-05","2024-05-12"),
(104,"Sport",106056,"2023-11-06","2024-03-21");
INSERT INTO Pro (Coach_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
(105,"Sport",194682,"2021-04-03","2025-10-25");
INSERT INTO Pro (Coach_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
(106,"Sport",156649,"2020-09-04","2025-01-08"),
(107,"Sport",125188,"2022-10-05","2025-01-21"),
(108,"Sport",134850,"2019-03-06","2026-11-24");
INSERT INTO Pro (Coach_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES
(109,"Sport",127778,"2021-11-06","2024-01-16"),
(110,"Sport",124745,"2021-09-05","2025-08-26"),
(111,"Sport",145006,"2020-12-06","2024-12-22"),
(112,"Sport",123781,"2021-08-02","2024-02-14"),
(113,"Sport",137288,"2021-08-04","2024-11-27"),
(114,"Sport",124605,"2020-08-06","2025-12-13");

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
INSERT INTO Management (Name,Manager_SSN) VALUES
("Sport",130),
("Events",135),
("Quality",140),
("Services",148),
("Board",149);
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