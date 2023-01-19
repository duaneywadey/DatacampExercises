CREATE TABLE cities (
  name                    VARCHAR   PRIMARY KEY,
  country_code            VARCHAR,
  city_proper_pop         REAL,
  metroarea_pop           REAL,
  urbanarea_pop           REAL
);

CREATE TABLE countries (
  code                  VARCHAR     PRIMARY KEY,
  name                  VARCHAR,
  continent             VARCHAR,
  region                VARCHAR,
  surface_area          REAL,
  indep_year            INTEGER,
  local_name            VARCHAR,
  gov_form              VARCHAR,
  capital               VARCHAR,
  cap_long              REAL,
  cap_lat               REAL
);

CREATE TABLE languages (
  lang_id               INTEGER     PRIMARY KEY,
  code                  VARCHAR,
  name                  VARCHAR,
  percent               REAL,
  official              BOOLEAN
);

CREATE TABLE economies (
  econ_id               INTEGER     PRIMARY KEY,
  code                  VARCHAR,
  year                  INTEGER,
  income_group          VARCHAR,
  gdp_percapita         REAL,
  gross_savings         REAL,
  inflation_rate        REAL,
  total_investment      REAL,
  unemployment_rate     REAL,
  exports               REAL,
  imports               REAL
);

CREATE TABLE currencies (
  curr_id               INTEGER     PRIMARY KEY,
  code                  VARCHAR,
  basic_unit            VARCHAR,
  curr_code             VARCHAR,
  frac_unit             VARCHAR,
  frac_perbasic         REAL
);

CREATE TABLE populations (
  pop_id                INTEGER     PRIMARY KEY,
  country_code          VARCHAR,
  year                  INTEGER,
  fertility_rate        REAL,
  life_expectancy       REAL,
  size                  REAL
);

CREATE TABLE economies2015 (
  code                  VARCHAR     PRIMARY KEY,
  year                  INTEGER,
  income_group          VARCHAR,
  gross_savings         REAL
);

CREATE TABLE economies2019 (
  code                  VARCHAR     PRIMARY KEY,
  year                  INTEGER,
  income_group          VARCHAR,
  gross_savings         REAL
);


-- CREATE TABLE countries_plus (
--   name                  VARCHAR,
--   continent             VARCHAR,
--   code                  VARCHAR     PRIMARY KEY,
--   surface_area          REAL,
--   geosize_group         VARCHAR
-- );

CREATE TABLE eu_countries (
  code                  VARCHAR     PRIMARY KEY,
  name                  VARCHAR
);

-- Copy over data from CSVs
COPY cities FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/cddfccbc63c3f4174cb05983e1d702f950e0dfa7/cities.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY economies FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/ec5372f648d672e3ef15ae863ed8a5bb9debf727/economies.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY currencies FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/bfc4b7c18b703d6b51f48effaec10e59e874a3f8/currencies.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY countries FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/a466156a6b08d11a1ef12acdb30fb499d2149672/countries.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY languages FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/acb77dbca3b267ef18329621c6d5a9f4d426c210/languages.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY populations FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/437c3551604412096e5d655368c33eb161d7ec8c/populations.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY eu_countries FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/5cc5739b7d2e5079e86d1fe75be0de8a927f9041/eu_countries.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY economies2015 FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/ce0bb6334965e7c1ab5416a70a64ea27012167b2/economies2015.csv"' (DELIMITER ',', FORMAT CSV, HEADER);
COPY economies2019 FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/6053/datasets/7430c0d1f620c524530a9a15640a436e771fbd6d/economies2019.csv"' (DELIMITER ',', FORMAT CSV, HEADER);

