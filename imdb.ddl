-- DDL for imdb database
-- all titles of the tables are the same as in the ER Diagram
CREATE DATABASE imdb_norahANDlogan;

CREATE TABLE titleBasics (
    titleId         varchar(255) NOT NULL,
    titleType       varchar(255) NOT NULL,
    primaryTitle    varchar(255) NOT NULL,
    originalTitle   varchar(255) NOT NULL,
    isAdult         int NOT NULL,
    startYear       numeric(4) NOT NULL,
    endYear         numeric(4),
    runtimeMinutes  int NOT NULL,
    PRIMARY KEY (titleId)
);

CREATE TABLE genres (
    titleID     varchar(255) NOT NULL,
    genres      varchar(255) NOT NULL,
    PRIMARY KEY (titleID, genres),
    FOREIGN KEY (titleID) REFERENCES titleBasics
);

CREATE TABLE ratings (
    titleID     varchar(255) NOT NULL,
    avgRating   int CHECK (avgRating >= 0 AND avgRating <= 10) NOT NULL,
    numVotes    int NOT NULL,
    PRIMARY KEY (titleID),
    FOREIGN KEY (titleID) REFERENCES titleBasics
);

CREATE TABLE episode (
    episodeTitleID      varchar(255) NOT NULL,
    parentTitleID       varchar(255) NOT NULL,
    seasonNumber        int NOT NULL,
    episodeNumber       int NOT NULL,
    PRIMARY KEY (episodeTitleID, parentTitleID),
    FOREIGN KEY (episodeTitleID) REFERENCES titleBasics
);

CREATE TABLE alternativeTitles (
    titleID             varchar(255) NOT NULL,
    ordering            int NOT NULL,
    title               varchar(255) NOT NULL,
    region              varchar(255) NOT NULL,
    language            varchar(255) NOT NULL,
    isOriginalTitle     varchar(255) NOT NULL,
    PRIMARY KEY (titleID, ordering),
    FOREIGN KEY (titleID) REFERENCES titleBasics
);

CREATE TABLE types (
    titleID             varchar(255) NOT NULL,
    ordering            int NOT NULL,
    attribute           varchar(255) NOT NULL,
    attributeOrdering   int NOT NULL,
    PRIMARY KEY (titleID, ordering, attribute, attributeOrdering),
    FOREIGN KEY (titleID) REFERENCES alternativeTitles,
    FOREIGN KEY (ordering) REFERENCES alternativeTitles
);

CREATE TABLE attributes (
    titleID     varchar(255) NOT NULL,
    ordering    int NOT NULL,
    attribute   varchar(255) NOT NULL,
    PRIMARY KEY (titleID, ordering, attribute),
    FOREIGN KEY (titleID) REFERENCES alternativeTitles,
    FOREIGN KEY (ordering) REFERENCES alternativeTitles
);

CREATE TABLE nameBasics (
    nameID      varchar(255) NOT NULL,
    personName  varchar(255) NOT NULL,
    birthYear   numeric(4) NOT NULL,
    deathYear   numeric(4),
    PRIMARY KEY (nameID)
);

CREATE TABLE principals (
    titleID     varchar(255) NOT NULL,
    nameID      varchar(255) NOT NULL,
    ordering    int NOT NULL,
    category    varchar(255) NOT NULL,
    job         varchar(255),
    characters  varchar(255),
    PRIMARY KEY (titleID, nameID, ordering),
    FOREIGN KEY (titleID) REFERENCES titleBasics,
    FOREIGN KEY (nameID) REFERENCES nameBasics
);

CREATE TABLE directors (
    titleID     varchar(255) NOT NULL,
    nameID      varchar(255) NOT NULL,
    PRIMARY KEY (titleID, nameID),
    FOREIGN KEY (titleID) REFERENCES titleBasics,
    FOREIGN KEY (nameID) REFERENCES nameBasics
);

CREATE TABLE writers (
    titleID     varchar(255) NOT NULL,
    nameID      varchar(255) NOT NULL,
    PRIMARY KEY (titleID, nameID),
    FOREIGN KEY (titleID) REFERENCES titleBasics,
    FOREIGN KEY (nameID) REFERENCES nameBasics
);

CREATE TABLE knownFor (
    nameID      varchar(255) NOT NULL,
    titleID     varchar(255) NOT NULL,
    PRIMARY KEY (nameID, titleID),
    FOREIGN KEY (nameID) REFERENCES nameBasics,
    FOREIGN KEY (titleID) REFERENCES titleBasics
);

CREATE TABLE primaryProfession (
    nameID      varchar(255) NOT NULL,
    profession  varchar(255) NOT NULL,
    PRIMARY KEY (nameID, profession),
    FOREIGN KEY (nameID) REFERENCES nameBasics
);