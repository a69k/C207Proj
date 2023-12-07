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
  `Date` DATE NOT NULL,
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
  `Location` VARCHAR(25) NOT NULL,
  `CateringName` VARCHAR(25) NOT NULL,
  `Supervisor_ssn` INT NOT NULL,
  PRIMARY KEY (`Location`, `CateringName`),
  CONSTRAINT `ay_haga`
    FOREIGN KEY (`Supervisor_ssn`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Catering_Location_Catering1`
    FOREIGN KEY (`CateringName`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Place`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Place` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Place` (
  `PlaceName` VARCHAR(25) NOT NULL,
  `Location` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`PlaceName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Club_DB`.`Hall`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`Hall` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`Hall` (
  `PlaceName` VARCHAR(25) NOT NULL,
  `NumberOfSeats` INT NOT NULL,
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
  `PlaceName` VARCHAR(25) NOT NULL,
  `Area` FLOAT NOT NULL,
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
  `Catering_Location` VARCHAR(25) NOT NULL,
  `Catering_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Worker_SSN`),
  CONSTRAINT `fk_table1_Employee1`
    FOREIGN KEY (`Worker_SSN`)
    REFERENCES `Club_DB`.`Employee` (`Employee_SSN`)
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
-- Table `Club_DB`.`teamSport_Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Club_DB`.`teamSport_Player` ;

CREATE TABLE IF NOT EXISTS `Club_DB`.`teamSport_Player` (
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
  `Catering_Name` VARCHAR(25) NOT NULL,
  `Item` VARCHAR(30) NOT NULL,
  `Price` FLOAT NOT NULL,
  PRIMARY KEY (`Catering_Name`, `Item`),
  CONSTRAINT `fk_Menu_Catering1`
    FOREIGN KEY (`Catering_Name`)
    REFERENCES `Club_DB`.`Catering` (`Name`)
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
  `Management_Name` VARCHAR(10) NOT NULL,
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
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pro_Management1`
    FOREIGN KEY (`Management_Name`)
    REFERENCES `Club_DB`.`Management` (`Name`)
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
-- Data for table `Club_DB`.`Event`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('Swimming Championship', '2023-12-23');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('FIFA Tournament', '2024-01-12');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('New Years Concert', '2023-12-31');
INSERT INTO `Club_DB`.`Event` (`Name`, `Date`) VALUES ('Watch Party', '2024-03-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Sponsor`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('Nike', 'Nike.com', 'Swimming Championship');
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('WE', 'te.eg', 'Fifa tournoment');
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('BanqueMisr', 'banquemisr.com', 'New Years Concert');
INSERT INTO `Club_DB`.`Sponsor` (`Name`, `Website`, `Event_Name`) VALUES ('Watch It', 'watchit.com', 'Watch Party');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Catering`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Azure', 'Catering', 2, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Sail In Sea', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Dominos', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Buffalo Burger', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Blaban', 'Catering', 1, 'Restaurant');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Vamos', 'Catering', 3, 'Cafe');
INSERT INTO `Club_DB`.`Catering` (`Name`, `Management_Name`, `NumOfBranches`, `Type`) VALUES ('Costa Cafe', 'Catering', 1, 'Cafe');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Catering_Location`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Main Club Building', 'Azure', 208);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Azure', 216);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Sail In Sea', 224);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Buffalo Burger', 238);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Dominos', 232);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Poolside', 'Dolato', 244);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Main Club Building', 'VAMOS', 249);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Poolside', 'VAMOS', 254);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Club Track', 'VAMOS', 259);
INSERT INTO `Club_DB`.`Catering_Location` (`Location`, `CateringName`, `Supervisor_ssn`) VALUES ('Food Court', 'Costa Coffee', 267);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Place`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Main Football Field ', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Indoor Sports Hall 1', 'Sports Complex Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Indoor Sports Hall 2', 'Sports Complex Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Poolside Lounge', 'Poolside');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Activity Hall 1', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Activity Hall 2', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Azure 1', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('VAMOS Trackside', 'Club Track');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Football Training Field 1', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Football Training Field 2', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Azure 2', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Buffalo Burger', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Domino\'s', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Sail In Sea', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Dolato', 'Poolside');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('VAMOS Lounge', 'Main Club Building');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('VAMOS Poolside', 'Poolside');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('Costa Coffee', 'Food Court');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('5on5 Football Field 1', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('5on5 Football Field 2', 'Sports Complex');
INSERT INTO `Club_DB`.`Place` (`PlaceName`, `Location`) VALUES ('5on5 Football Field 3', 'Sports Complex');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Hall`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Indoor Sports Hall 1', 2000);
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Indoor Sports Hall 2', 600);
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Activity Hall 1', 100);
INSERT INTO `Club_DB`.`Hall` (`PlaceName`, `NumberOfSeats`) VALUES ('Activity Hall 2', 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Field`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Main Football Field ', 7140);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Football Training Field 1', 5000);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Football Training Field 2', 5000);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('Club Track', 1117.51);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('5on5 Football Field 1', 800);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('5on5 Football Field 2', 800);
INSERT INTO `Club_DB`.`Field` (`PlaceName`, `Area`) VALUES ('5on5 Football Field 3', 800);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Club_DB`.`Menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `Club_DB`;
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Kofta', 180.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Shish Tawook', 164.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Grilled Chicken', 118.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Alfredo Pasta', 100.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Mushroom Cream Soup', 39.5);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'Shrimp Pasta', 125.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'Fried Shrimp Sandwich', 80.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'seafood soup', 65.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'panne sandwich', 49.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('sail in sea', 'caviar salad', 30.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'pepperoni pizza', 150.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'margherita pizza', 100.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'Chicken ranch pizza', 135.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'Chicken BBQ Pizza', 140.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dominos', 'Veggie Pizza', 110.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Mushroom burger', 90.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Bacon Burger', 105.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Cheese Burger', 80.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Chicken Burger', 90.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Buffalo', 'Cheese Fries', 35.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Bubble Waffle', 35.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Tiramisu', 50.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Frozen Yogurt', 34.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Gelato', 30.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Dolato', 'Cheesecake', 40.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Turkish coffee', 12.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Tea', 8.5);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Anise', 10.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'BBQ Chicken Sandwich', 74.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'French Coffee', 20.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Breakfast Sandwich', 16.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('VAMOS', 'Fresh Juice', 33.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Cafe', 'Croissant', 25.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Cafe', 'Ice coffee', 45.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Cafe', 'espresso', 25.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Cafe', 'Club Sandwich', 65.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Costa Cafe', 'Cappuccino', 40.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Tehina', 20.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Cesar Salad', 45.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Rice', 18.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Molokhia', 45.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'Fahita Sandwich', 50.0);
INSERT INTO `Club_DB`.`Menu` (`Catering_Name`, `Item`, `Price`) VALUES ('Azure', 'French Fries', 26.0);

COMMIT;

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
INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES
(201, "Amal", "Salah", "62 Talaat Harb, Downtown, Cairo", "01109418362", "1996-02-03", "F", "AmalSalah222@hotmail.com"),
(202, "Amir", "Magdy", "14 Gamal Abdel Nasser, Al-Salam, Cairo", "01086172493", "1996-06-27", "M", "AmirMagdy132@outlook.com"),
(203, "Kareem", "Emad", "27 9 St., Maadi, Cairo", "01595728604", "1997-02-10", "M", "KareemEmad161@gmail.com"),
(204, "Esraa", "Salah", "50 Adly, Downtown, Cairo", "01062398750", "1997-08-13", "F", "EsraaSalah285@gmail.com"),
(205, "Sherif", "Salah", "59 Champeleon, Downtown, Cairo", "01295410236", "1995-05-08", "M", "SherifSalah197@gmail.com"),
(206, "Amani", "Salah", "17 Gamal Abdel Nasser, Al-Salam, Cairo", "01151963780", "1997-07-28", "F", "AmaniSalah288@outlook.com"),
(207, "Mahmoud", "Fawzi", "60 Al Nahda, Maadi, Cairo", "01213724580", "1995-05-09", "M", "MahmoudFawzi330@outlook.com"),
(208, "Rashad", "Ezzat", "34 28St. ,ElTahrir City, Imbaba, Giza", "01549612573", "1997-09-16", "M", "RashadEzzat155@gmail.com"),
(209, "Shahd", "Khalil", "11 Al Teraa Al Boulakeya, Shobra, Cairo", "01049752831", "2003-09-14", "F", "ShahdKhalil59@outlook.com"),
(210, "Nada", "Adel", "88 Hassan Assem, Zamalek, Cairo", "01106431728", "2000-04-22", "F", "NadaAdel15@gmail.com"),
(211, "Salma", "Fawzi", "80 Al Saad Al Aaly, Maadi, Cairo", "01520746385", "1995-04-20", "F", "SalmaFawzi251@outlook.com"),
(212, "Nour", "Hani", "22 Gamal Abdel Nasser, Al-Salam, Cairo", "01563594827", "1995-02-03", "F", "NourHani284@gmail.com"),
(213, "Sherif", "Magdy", "28 Doletyan, Shobra, Cairo", "01598065173", "2003-08-18", "M", "SherifMagdy85@outlook.com"),
(214, "Hager", "Waleed", "35 Baghdad, Heliopolis, Cairo", "01090283674", "2002-04-19", "F", "HagerWaleed267@outlook.com"),
(215, "Rashad", "Magdy", "49 15 May, Shobra, Cairo", "01095103278", "1999-07-07", "M", "RashadMagdy382@outlook.com"),
(216, "Mariam", "Nader", "18 El Sadat, Al-Salam, Cairo", "01514386972", "1996-02-23", "F", "MariamNader348@hotmail.com"),
(217, "Kareem", "Emad", "86 Gamal Abdel Nasser, Al-Salam, Cairo", "01252891067", "2003-08-12", "M", "KareemEmad191@hotmail.com"),
(218, "Abdallah", "Khalil", "25 151 St., Maadi, Cairo", "01201523849", "1998-09-14", "M", "AbdallahKhalil132@hotmail.com"),
(219, "Ali", "Sayed", "75 Al Nahda, Maadi, Cairo", "01272385941", "2000-08-12", "M", "AliSayed108@outlook.com"),
(220, "Ali", "Khalil", "64 Gad Eid, Al Doqi, Giza", "01576450928", "1999-11-18", "M", "AliKhalil296@outlook.com"),
(221, "Hana", "Ghanim", "93 26 July St, Downtown, Cairo", "01115743082", "1996-06-13", "F", "HanaGhanim305@gmail.com"),
(222, "Nourhan", "Ghanim", "5 Hassan Ramadan, Al Doqi, Giza", "01128395706", "1995-01-01", "F", "NourhanGhanim51@gmail.com"),
(223, "Noureen", "Khalil", "9 Al Saad Al Aaly, Maadi, Cairo", "01294537810", "2001-09-14", "F", "NoureenKhalil272@outlook.com"),
(224, "Sherif", "Khaled", "11 18St. , ElTahrir City, Imbaba, Giza", "01180476219", "2001-06-25", "M", "SherifKhaled299@outlook.com"),
(225, "Aya", "Salah", "41 Al Kanal, Maadi, Cairo", "01518049325", "2001-05-07", "F", "AyaSalah188@gmail.com"),
(226, "Rashad", "Sayed", "52 El Sadat, Al-Salam, Cairo", "01280365974", "2000-03-28", "M", "RashadSayed296@outlook.com"),
(227, "Ehab", "Zakaria", "10 Al Hegaz, Heliopolis, Cairo", "01167935201", "1994-06-19", "M", "EhabZakaria117@outlook.com"),
(228, "Mahmoud", "Ashraf", "52 Damascus, Maadi, Cairo", "01116457098", "1998-08-14", "M", "MahmoudAshraf371@hotmail.com"),
(229, "Yara", "Fawzi", "29 Hassan Sabry, Zamalek, Cairo", "01130761489", "2003-12-20", "F", "YaraFawzi112@gmail.com"),
(230, "Ahmed", "Zakaria", "6 Al Nozha, Heliopolis, Cairo", "01508436179", "1997-11-03", "M", "AhmedZakaria306@gmail.com"),
(231, "Esraa", "Hani", "14 Gamal Abdel Nasser, Al-Salam, Cairo", "01594281065", "2000-04-03", "F", "EsraaHani75@gmail.com"),
(232, "Rashad", "Khaled", "13 El Tahrir, Downtown, Cairo", "01002187936", "2001-04-13", "M", "RashadKhaled249@gmail.com"),
(233, "Hager", "Ezzat", "98 Shobra St., Shobra, Cairo", "01028390457", "1996-11-16", "F", "HagerEzzat415@outlook.com"),
(234, "Mahmoud", "Emad", "58 Al Nadi, Maadi, Cairo", "01291287054", "2001-10-08", "M", "MahmoudEmad87@hotmail.com"),
(235, "Esraa", "Yaser", "18 Shagaret Al Dor, Zamalek, Cairo", "01575491368", "1997-03-08", "F", "EsraaYaser183@gmail.com"),
(236, "Toaa", "Magdy", "8 Gad Eid, Al Doqi, Giza", "01202786315", "1994-08-06", "F", "ToaaMagdy346@hotmail.com"),
(237, "Zeyad", "Emad", "36 Doletyan, Shobra, Cairo", "01592134867", "1998-11-15", "M", "ZeyadEmad102@hotmail.com"),
(238, "Amr", "Khaled", "7 Talaat Harb, Imbaba, Giza", "01572619508", "2003-06-08", "M", "AmrKhaled53@gmail.com"),
(239, "Toaa", "Sayed", "59 Adly, Downtown, Cairo", "01510956782", "1999-12-03", "F", "ToaaSayed280@hotmail.com"),
(240, "Esraa", "Nader", "55 Bahgat Ali, Zamalek, Cairo", "01149208536", "1996-01-28", "F", "EsraaNader270@outlook.com"),
(241, "Abdelrahman", "Khaled", "95 Sherif, Downtown, Cairo", "01007524813", "1996-03-17", "M", "AbdelrahmanKhaled274@gmail.com"),
(242, "Sherif", "Adel", "41 Oraby, Maadi, Cairo", "01153026147", "1995-11-04", "M", "SherifAdel335@outlook.com"),
(243, "Mariam", "Hassan", "90 Al Ahram, Heliopolis, Cairo", "01056734902", "2003-06-20", "F", "MariamHassan390@outlook.com"),
(244, "Nour", "Ezzat", "42 Hassan Sabry, Zamalek, Cairo", "01284013697", "1995-12-16", "F", "NourEzzat256@outlook.com"),
(245, "Eman", "Magdy", "18 Champeleon, Downtown, Cairo", "01591865047", "2000-02-14", "F", "EmanMagdy285@hotmail.com"),
(246, "Nourhan", "Hani", "83 Al Merghany, Heliopolis, Cairo", "01087016529", "1998-08-18", "F", "NourhanHani25@outlook.com"),
(247, "Mohamed", "Waleed", "97 Gad Eid, Al Doqi, Giza", "01025781630", "1996-01-10", "M", "MohamedWaleed129@hotmail.com"),
(248, "Shahd", "Sobhi", "35 Champeleon, Downtown, Cairo", "01043501928", "2000-04-12", "F", "ShahdSobhi253@hotmail.com"),
(249, "Mahmoud", "Fawzi", "82 Gad Eid, Al Doqi, Giza", "01238540619", "2002-11-22", "M", "MahmoudFawzi17@hotmail.com"),
(250, "Marawan", "Khaled", "14 kamal Al Tawil, Zamalek, Cairo", "01028369701", "1996-01-08", "M", "MarawanKhaled42@hotmail.com"),
(251, "Mostafa", "Sayed", "84 Baghdad, Heliopolis, Cairo", "01527196345", "2000-08-11", "M", "MostafaSayed352@outlook.com"),
(252, "Rashad", "Sayed", "100 Al Teraa Al Boulakeya, Shobra, Cairo", "01268720951", "2001-10-11", "M", "RashadSayed129@hotmail.com"),
(253, "Mohamed", "Hani", "28 9 St., Maadi, Cairo", "01249702683", "1995-11-27", "M", "MohamedHani241@outlook.com"),
(254, "Ali", "Farag", "88 15 May, Shobra, Cairo", "01579451236", "2001-07-14", "M", "AliFarag372@hotmail.com"),
(255, "Aya", "Salah", "26 Gad Eid, Al Doqi, Giza", "01109348625", "1997-10-04", "F", "AyaSalah92@hotmail.com"),
(256, "Ali", "Mohamed", "29 Mamdouh Salem, Imbaba, Giza", "01538967540", "1995-01-25", "M", "AliMohamed163@gmail.com"),
(257, "Abdalaziz", "Ezzat", "78 Baghdad, Heliopolis, Cairo", "01185710924", "1998-08-21", "M", "AbdalazizEzzat71@hotmail.com"),
(258, "Haytham", "Nader", "33 18St. , ElTahrir City, Imbaba, Giza", "01217896502", "1999-02-28", "M", "HaythamNader294@gmail.com"),
(259, "Mostafa", "Sayed", "86 Al Merghany, Heliopolis, Cairo", "01023904786", "1997-09-18", "M", "MostafaSayed145@outlook.com"),
(260, "Amani", "Hassan", "84 Al Nadi, Maadi, Cairo", "01254670398", "1994-01-09", "F", "AmaniHassan177@gmail.com"),
(261, "Mahmoud", "Ashraf", "65 Shaheen, Al Doqi, Giza", "01280927364", "1997-07-18", "M", "MahmoudAshraf65@outlook.com"),
(262, "Ibrahim", "Ashraf", "13 Shobra St., Shobra, Cairo", "01297483512", "2003-12-16", "M", "IbrahimAshraf141@hotmail.com"),
(263, "Amal", "Ashraf", "90 Doletyan, Shobra, Cairo", "01102597134", "1994-08-20", "F", "AmalAshraf113@outlook.com"),
(264, "Aya", "Hassan", "98 Gamal Abdel Nasser, Al-Salam, Cairo", "01562597381", "2002-02-28", "F", "AyaHassan156@outlook.com"),
(265, "Hager", "Emad", "100 Hassan Ramadan, Al Doqi, Giza", "01292716043", "1999-04-01", "F", "HagerEmad313@gmail.com"),
(266, "Eyad", "Khalil", "64 Gamal Abdel Nasser, Al-Salam, Cairo", "01094561237", "1994-01-20", "M", "EyadKhalil381@gmail.com"),
(267, "Amani", "Emad", "82 Hassan Assem, Zamalek, Cairo", "01043097162", "1997-03-28", "F", "AmaniEmad152@outlook.com");
INSERT INTO employee (Employee_SSN,Salary) VALUES
(201,50014),
(202,52358),
(203,52213),
(204,52513),
(205,52532),
(206,49880),
(207,54920),
(208,90000),
(209,52118),
(210,51135),
(211,48826),
(212,50144),
(213,52281),
(214,51642),
(215,52862),
(216,90000),
(217,49044),
(218,54482),
(219,50147),
(220,49752),
(221,53561),
(222,52766),
(223,52935),
(224,87500),
(225,51668),
(226,53573),
(227,49987),
(228,53104),
(229,50778),
(230,48312),
(231,48638),
(232,90000),
(233,48394),
(234,53354),
(235,54066),
(236,50447),
(237,48486),
(238,87500),
(239,49813),
(240,49365),
(241,53241),
(242,48523),
(243,48380),
(244,88000),
(245,54032),
(246,50613),
(247,53402),
(248,54106),
(249,82500),
(250,49879),
(251,49150),
(252,54024),
(253,50835),
(254,82500),
(255,48600),
(256,49076),
(257,48299),
(258,49161),
(259,82500),
(260,53354),
(261,50037),
(262,48907),
(263,51407),
(264,49817),
(265,54576),
(266,54773),
(267,87600);
INSERT INTO CateringStaff (Worker_SSN,Catering_Name,Catering_Location) VALUES
(201,'Azure','Main Club Building'),
(202,'Azure','Main Club Building'),
(203,'Azure','Main Club Building'),
(204,'Azure','Main Club Building'),
(205,'Azure','Main Club Building'),
(206,'Azure','Main Club Building'),
(207,'Azure','Main Club Building'),
(208,'Azure','Main Club Building'),
(209,'Azure','Food Court'),
(210,'Azure','Food Court'),
(211,'Azure','Food Court'),
(212,'Azure','Food Court'),
(213,'Azure','Food Court'),
(214,'Azure','Food Court'),
(215,'Azure','Food Court'),
(216,'Azure','Food Court'),
(217,'Sail In Sea','Food Court'),
(218,'Sail In Sea','Food Court'),
(219,'Sail In Sea','Food Court'),
(220,'Sail In Sea','Food Court'),
(221,'Sail In Sea','Food Court'),
(222,'Sail In Sea','Food Court'),
(223,'Sail In Sea','Food Court'),
(224,'Sail In Sea','Food Court'),
(225,'Dominos','Food Court'),
(226,'Dominos','Food Court'),
(227,'Dominos','Food Court'),
(228,'Dominos','Food Court'),
(229,'Dominos','Food Court'),
(230,'Dominos','Food Court'),
(231,'Dominos','Food Court'),
(232,'Dominos','Food Court'),
(233,'Buffalo Burger','Food Court'),
(234,'Buffalo Burger','Food Court'),
(235,'Buffalo Burger','Food Court'),
(236,'Buffalo Burger','Food Court'),
(237,'Buffalo Burger','Food Court'),
(238,'Buffalo Burger','Food Court'),
(239,'Dolato','Poolside'),
(240,'Dolato','Poolside'),
(241,'Dolato','Poolside'),
(242,'Dolato','Poolside'),
(243,'Dolato','Poolside'),
(244,'Dolato','Poolside'),
(245,'VAMOS','Main Club Building'),
(246,'VAMOS','Main Club Building'),
(247,'VAMOS','Main Club Building'),
(248,'VAMOS','Main Club Building'),
(249,'VAMOS','Main Club Building'),
(250,'VAMOS','Poolside'),
(251,'VAMOS','Poolside'),
(252,'VAMOS','Poolside'),
(253,'VAMOS','Poolside'),
(254,'VAMOS','Poolside'),
(255,'VAMOS','Club Track'),
(256,'VAMOS','Club Track'),
(257,'VAMOS','Club Track'),
(258,'VAMOS','Club Track'),
(259,'VAMOS','Club Track'),
(260,'Costa Coffee','Food Court'),
(261,'Costa Coffee','Food Court'),
(262,'Costa Coffee','Food Court'),
(263,'Costa Coffee','Food Court'),
(264,'Costa Coffee','Food Court'),
(265,'Costa Coffee','Food Court'),
(266,'Costa Coffee','Food Court'),
(267,'Costa Coffee','Food Court');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=0;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;