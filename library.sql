
DROP TABLE book;
DROP TABLE author;

CREATE TABLE author (
    auth_id SERIAL NOT NULL PRIMARY KEY,
    a_name VARCHAR(50)
);

CREATE TABLE book (
    book_id SERIAL NOT NULL PRIMARY KEY,
    b_title VARCHAR(100) NOT NULL,
    b_author INTEGER NOT NULL REFERENCES author(auth_id),
    b_isbn VARCHAR(20) NOT NULL UNIQUE,
    b_pub_date DATE,
    b_price DECIMAL(10,2),
    b_plot VARCHAR(500)
);

INSERT INTO author VALUES ( 100, '<unknown author>' );

INSERT INTO author VALUES ( 101, 'Stephen KING' );
INSERT INTO book VALUES ( 10101, 'The Talisman',  101, '978-0-670-69199-9',  '1984-11-08', 15.60, 'Jack Sawyer, twelve years old, sets out from Arcadia Beach, New Hampshire, in a bid to save his mother Lily, who is dying from cancer, by finding a crystal called "the Talisman". Jack''s journey takes him simultaneously through the American heartland and "the Territories"...' );
INSERT INTO book VALUES ( 10102, 'Doctor Sleep',  101, '978-1-4767-2765-3',  '2013-09-24', 12.00, 'Following the events of The Shining, after receiving a settlement from the owners of the Overlook Hotel, Danny Torrance remains psychologically traumatized as his mother Wendy slowly recovers from her injuries...' );
INSERT INTO book VALUES ( 10103, 'The Long Walk', 101, '978-0-451-08754-6',  '1979-07-11', 14.30, 'In a dystopian America, a major source of entertainment is the Long Walk, in which one hundred teenage boys walk without rest along U.S. Route 1. Each Walker must stay above four miles per hour...' );
INSERT INTO book VALUES ( 10104, 'Firestarter',   101, '978-0670315413',     '1980-09-29', 13.50, 'Andrew "Andy" and Charlene "Charlie" McGee are a father/daughter pair on the run from a government agency known as The Shop. During his college years, Andy had participated in a Shop experiment dealing with "Lot 6", a drug with hallucinogenic effects similar to LSD. The drug gave his future wife, ...' );
INSERT INTO book VALUES ( 10105, 'Duma Key',      101, '978-1-4165-5251-2',  '2008-01-22', 11.40, 'Edgar Freemantle, a wealthy Minnesotan building contractor, barely survives a severe worksite accident wherein his truck is crushed by a crane. Edgar loses his right arm while suffering severe head injuries impairing his speech, ...' );

INSERT INTO author VALUES ( 102, 'James Patterson' );
INSERT INTO book VALUES ( 10201, 'Along Came a Spider', 102, '0-316-69364-2',      '1993-03-23', 11.20, 'Washington, D.C. homicide investigator and forensic psychologist Alex Cross investigates the brutal murders of two black prostitutes and an infant. Then, at an exclusive private school, math teacher Gary Soneji kidnaps Maggie Rose Dunne and Michael Goldberg. Cross is pulled off the murder case to investigate the kidnapping instead.' );
INSERT INTO book VALUES ( 10202, 'Kiss the Girls',      102, '0-316-69370-7',      '1995-01-11', 12.40, 'As a teenage boy in 1975 Boca Raton, Florida, a future serial killer calling himself Casanova kills his first four victims. Elsewhere in 1981 Chapel Hill, North Carolina, another killer calling himself The Gentleman Caller kills a young couple on a lake...' );
INSERT INTO book VALUES ( 10203, 'The Big Bad Wolf',    102, '978-0-316-60290-7',  '2003-11-17', 14.50, 'Cross is in the middle of his training at the FBI when he is assigned to work on a kidnapping case. A federal judge''s wife has been kidnapped, and Cross discovers that her kidnapping fits the pattern of other recent kidnappings...' );

INSERT INTO author VALUES ( 103, 'Dan Brown' );
INSERT INTO book VALUES ( 10301, 'Digital Fortress',  103, '0-312-18087-X',      '1998-01-01', 10.20, 'The story is set in the year of 1996. When the United States National Security Agency''s (NSA) code-breaking supercomputer TRANSLTR encounters a revolutionary new code, Digital Fortress, that it cannot break, Commander Trevor Strathmore calls in head cryptographer Susan Fletcher to crack it.' );
INSERT INTO book VALUES ( 10302, 'Angels & Demons', 103, '0-671-02735-2 ',     '2000-04-01', 14.55, 'Leonardo Vetra, one of CERN''s top physicists who have discovered how to create antimatter, is murdered, his chest branded with an ambigram of the word "Illuminati", an ancient anti-religious organization thought extinct. CERN director Maximilian Kohler calls Vetra''s adopted daughter, Vittoria, and Robert Langdon, an expert on symbology and religious history, for help. After determining the ambigram is authentic...' );
INSERT INTO book VALUES ( 10303, 'The Da Vinci Code', 103, '0-385-50420-9',      '2003-03-18', 11.00, 'Louvre curator and Priory of Sion grand master Jacques Saunière is fatally shot one night at the museum by an albino Catholic monk named Silas, who is working on behalf of someone he knows only as the Teacher, who wishes to discover the location of the "keystone," an item crucial in the search for the Holy Grail...' );
INSERT INTO book VALUES ( 10304, 'The Lost Symbol',   103, '978-0-385-50422-5 ', '2009-09-15', 11.40, 'Renowned Harvard symbologist Robert Langdon is invited to give a lecture at the United States Capitol, at the invitation apparently from his mentor, a 33rd degree Mason named Peter Solomon, who is the head of the Smithsonian Institution. Solomon has also asked him to bring a small, sealed package which he had entrusted to Langdon years earlier. When Langdon arrives at the Capitol, however, he learns that the invitation he received was not from Solomon, ...' );

SELECT setval( pg_get_serial_sequence('author','auth_id'), 200);

SELECT setval( pg_get_serial_sequence('book','book_id'), 20000);
