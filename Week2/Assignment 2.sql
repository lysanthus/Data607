/* Create the tables */
CREATE TABLE public.movies
(
    "movieID" integer NOT NULL,
    "movieName" character varying(200), 
    year integer, 
    CONSTRAINT movies_pkey PRIMARY KEY ("movieID")
);

CREATE TABLE public.person
(
    "personID" integer NOT NULL,
    "lastName" character varying(20),
    "firstName" character varying(40),
    CONSTRAINT person_pkey PRIMARY KEY ("personID")
);

CREATE TABLE public.ratings
(
    "movieID" integer,
    "personID" integer,
    rating integer,
    PRIMARY KEY ("movieID", "personID"),
    CONSTRAINT fk_movie FOREIGN KEY ("movieID")
        REFERENCES public.movies ("movieID"),
    CONSTRAINT fk_person FOREIGN KEY ("personID")
        REFERENCES public.person ("personID"),
    CONSTRAINT ck_rating CHECK (rating >= 0 AND rating <= 5)
);

/* Load the movies */
insert into public.movies
("movieID", "movieName", year)
values (1, 'Avengers: Infinity War', 2018);

insert into public.movies
("movieID", "movieName", year)
values (2, 'BlacKkKlansman', 2018);

insert into public.movies
("movieID", "movieName", year)
values (3, 'Crazy Rich Asians', 2018);

insert into public.movies
("movieID", "movieName", year)
values (4, 'Won''t You Be My Neighbor?', 2018);

insert into public.movies
("movieID", "movieName", year)
values (5, 'A Quiet Place', 2018);

insert into public.movies
("movieID", "movieName", year)
values (6, 'Three BIillboards Outside Ebbing, Missouri', 2017);

/* Load the people */
insert into public.person
("personID", "lastName", "firstName")
values (1, 'Douglas', 'Adam');

insert into public.person
("personID", "lastName", "firstName")
values (2, 'Douglas', 'April');

insert into public.person
("personID", "lastName", "firstName")
values (3, 'Douglas', 'Amber');

insert into public.person
("personID", "lastName", "firstName")
values (4, 'Douglas', 'Tyler');

insert into public.person
("personID", "lastName", "firstName")
values (5, 'Douglas', 'Brianna');

/* Load the ratings */
insert into public.ratings
("movieID", "personID", rating)
values (1,1,5);

insert into public.ratings
("movieID", "personID", rating)
values (1,4,4);

insert into public.ratings
("movieID", "personID", rating)
values (1,5,5);

insert into public.ratings
("movieID", "personID", rating)
values (2,1,4);

insert into public.ratings
("movieID", "personID", rating)
values (2,2,3);

insert into public.ratings
("movieID", "personID", rating)
values (2,3,4);

insert into public.ratings
("movieID", "personID", rating)
values (3,2,4);

insert into public.ratings
("movieID", "personID", rating)
values (3,3,5);

insert into public.ratings
("movieID", "personID", rating)
values (3,5,5);

insert into public.ratings
("movieID", "personID", rating)
values (4,1,5);

insert into public.ratings
("movieID", "personID", rating)
values (4,2,5);

insert into public.ratings
("movieID", "personID", rating)
values (4,3,4);

insert into public.ratings
("movieID", "personID", rating)
values (4,4,3);

insert into public.ratings
("movieID", "personID", rating)
values (4,5,4);

insert into public.ratings
("movieID", "personID", rating)
values (5,1,4);

insert into public.ratings
("movieID", "personID", rating)
values (5,2,3);

insert into public.ratings
("movieID", "personID", rating)
values (5,3,2);

insert into public.ratings
("movieID", "personID", rating)
values (5,5,4);

insert into public.ratings
("movieID", "personID", rating)
values (6,1,4);

insert into public.ratings
("movieID", "personID", rating)
values (6,2,5);

insert into public.ratings
("movieID", "personID", rating)
values (6,4,5);