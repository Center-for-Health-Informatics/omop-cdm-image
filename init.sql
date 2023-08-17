CREATE DATABASE $(DB_NAME);
GO

USE $(DB_NAME);
GO

CREATE LOGIN $(DB_LOGIN) WITH PASSWORD='$(DB_PW)', DEFAULT_DATABASE=$(DB_NAME);
GO

CREATE USER $(DB_NAME)_user FOR LOGIN $(DB_LOGIN) WITH DEFAULT_SCHEMA=dbo;
GO

ALTER ROLE db_owner ADD MEMBER $(DB_NAME)_user;
GO

--sql server CDM DDL Specification for OMOP Common Data Model 5.4
--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE PERSON (
			person_id integer NOT NULL,
			gender_concept_id integer NOT NULL,
			year_of_birth integer NOT NULL,
			month_of_birth integer NULL,
			day_of_birth integer NULL,
			birth_datetime datetime NULL,
			race_concept_id integer NOT NULL,
			ethnicity_concept_id integer NOT NULL,
			location_id integer NULL,
			provider_id integer NULL,
			care_site_id integer NULL,
			person_source_value varchar(50) NULL,
			gender_source_value varchar(50) NULL,
			gender_source_concept_id integer NULL,
			race_source_value varchar(50) NULL,
			race_source_concept_id integer NULL,
			ethnicity_source_value varchar(50) NULL,
			ethnicity_source_concept_id integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE OBSERVATION_PERIOD (
			observation_period_id integer NOT NULL,
			person_id integer NOT NULL,
			observation_period_start_date date NOT NULL,
			observation_period_end_date date NOT NULL,
			period_type_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE VISIT_OCCURRENCE (
			visit_occurrence_id integer NOT NULL,
			person_id integer NOT NULL,
			visit_concept_id integer NOT NULL,
			visit_start_date date NOT NULL,
			visit_start_datetime datetime NULL,
			visit_end_date date NOT NULL,
			visit_end_datetime datetime NULL,
			visit_type_concept_id Integer NOT NULL,
			provider_id integer NULL,
			care_site_id integer NULL,
			visit_source_value varchar(50) NULL,
			visit_source_concept_id integer NULL,
			admitted_from_concept_id integer NULL,
			admitted_from_source_value varchar(50) NULL,
			discharged_to_concept_id integer NULL,
			discharged_to_source_value varchar(50) NULL,
			preceding_visit_occurrence_id integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE VISIT_DETAIL (
			visit_detail_id integer NOT NULL,
			person_id integer NOT NULL,
			visit_detail_concept_id integer NOT NULL,
			visit_detail_start_date date NOT NULL,
			visit_detail_start_datetime datetime NULL,
			visit_detail_end_date date NOT NULL,
			visit_detail_end_datetime datetime NULL,
			visit_detail_type_concept_id integer NOT NULL,
			provider_id integer NULL,
			care_site_id integer NULL,
			visit_detail_source_value varchar(50) NULL,
			visit_detail_source_concept_id Integer NULL,
			admitted_from_concept_id Integer NULL,
			admitted_from_source_value varchar(50) NULL,
			discharged_to_source_value varchar(50) NULL,
			discharged_to_concept_id integer NULL,
			preceding_visit_detail_id integer NULL,
			parent_visit_detail_id integer NULL,
			visit_occurrence_id integer NOT NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE CONDITION_OCCURRENCE (
			condition_occurrence_id integer NOT NULL,
			person_id integer NOT NULL,
			condition_concept_id integer NOT NULL,
			condition_start_date date NOT NULL,
			condition_start_datetime datetime NULL,
			condition_end_date date NULL,
			condition_end_datetime datetime NULL,
			condition_type_concept_id integer NOT NULL,
			condition_status_concept_id integer NULL,
			stop_reason varchar(20) NULL,
			provider_id integer NULL,
			visit_occurrence_id integer NULL,
			visit_detail_id integer NULL,
			condition_source_value varchar(50) NULL,
			condition_source_concept_id integer NULL,
			condition_status_source_value varchar(50) NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE DRUG_EXPOSURE (
			drug_exposure_id integer NOT NULL,
			person_id integer NOT NULL,
			drug_concept_id integer NOT NULL,
			drug_exposure_start_date date NOT NULL,
			drug_exposure_start_datetime datetime NULL,
			drug_exposure_end_date date NOT NULL,
			drug_exposure_end_datetime datetime NULL,
			verbatim_end_date date NULL,
			drug_type_concept_id integer NOT NULL,
			stop_reason varchar(20) NULL,
			refills integer NULL,
			quantity float NULL,
			days_supply integer NULL,
			sig varchar(MAX) NULL,
			route_concept_id integer NULL,
			lot_number varchar(50) NULL,
			provider_id integer NULL,
			visit_occurrence_id integer NULL,
			visit_detail_id integer NULL,
			drug_source_value varchar(50) NULL,
			drug_source_concept_id integer NULL,
			route_source_value varchar(50) NULL,
			dose_unit_source_value varchar(50) NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE PROCEDURE_OCCURRENCE (
			procedure_occurrence_id integer NOT NULL,
			person_id integer NOT NULL,
			procedure_concept_id integer NOT NULL,
			procedure_date date NOT NULL,
			procedure_datetime datetime NULL,
			procedure_end_date date NULL,
			procedure_end_datetime datetime NULL,
			procedure_type_concept_id integer NOT NULL,
			modifier_concept_id integer NULL,
			quantity integer NULL,
			provider_id integer NULL,
			visit_occurrence_id integer NULL,
			visit_detail_id integer NULL,
			procedure_source_value varchar(50) NULL,
			procedure_source_concept_id integer NULL,
			modifier_source_value varchar(50) NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE DEVICE_EXPOSURE (
			device_exposure_id integer NOT NULL,
			person_id integer NOT NULL,
			device_concept_id integer NOT NULL,
			device_exposure_start_date date NOT NULL,
			device_exposure_start_datetime datetime NULL,
			device_exposure_end_date date NULL,
			device_exposure_end_datetime datetime NULL,
			device_type_concept_id integer NOT NULL,
			unique_device_id varchar(255) NULL,
			production_id varchar(255) NULL,
			quantity integer NULL,
			provider_id integer NULL,
			visit_occurrence_id integer NULL,
			visit_detail_id integer NULL,
			device_source_value varchar(50) NULL,
			device_source_concept_id integer NULL,
			unit_concept_id integer NULL,
			unit_source_value varchar(50) NULL,
			unit_source_concept_id integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE MEASUREMENT (
			measurement_id integer NOT NULL,
			person_id integer NOT NULL,
			measurement_concept_id integer NOT NULL,
			measurement_date date NOT NULL,
			measurement_datetime datetime NULL,
			measurement_time varchar(10) NULL,
			measurement_type_concept_id integer NOT NULL,
			operator_concept_id integer NULL,
			value_as_number float NULL,
			value_as_concept_id integer NULL,
			unit_concept_id integer NULL,
			range_low float NULL,
			range_high float NULL,
			provider_id integer NULL,
			visit_occurrence_id integer NULL,
			visit_detail_id integer NULL,
			measurement_source_value varchar(50) NULL,
			measurement_source_concept_id integer NULL,
			unit_source_value varchar(50) NULL,
			unit_source_concept_id integer NULL,
			value_source_value varchar(50) NULL,
			measurement_event_id integer NULL,
			meas_event_field_concept_id integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE OBSERVATION (
			observation_id integer NOT NULL,
			person_id integer NOT NULL,
			observation_concept_id integer NOT NULL,
			observation_date date NOT NULL,
			observation_datetime datetime NULL,
			observation_type_concept_id integer NOT NULL,
			value_as_number float NULL,
			value_as_string varchar(60) NULL,
			value_as_concept_id Integer NULL,
			qualifier_concept_id integer NULL,
			unit_concept_id integer NULL,
			provider_id integer NULL,
			visit_occurrence_id integer NULL,
			visit_detail_id integer NULL,
			observation_source_value varchar(50) NULL,
			observation_source_concept_id integer NULL,
			unit_source_value varchar(50) NULL,
			qualifier_source_value varchar(50) NULL,
			value_source_value varchar(50) NULL,
			observation_event_id integer NULL,
			obs_event_field_concept_id integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE DEATH (
			person_id integer NOT NULL,
			death_date date NOT NULL,
			death_datetime datetime NULL,
			death_type_concept_id integer NULL,
			cause_concept_id integer NULL,
			cause_source_value varchar(50) NULL,
			cause_source_concept_id integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE NOTE (
			note_id integer NOT NULL,
			person_id integer NOT NULL,
			note_date date NOT NULL,
			note_datetime datetime NULL,
			note_type_concept_id integer NOT NULL,
			note_class_concept_id integer NOT NULL,
			note_title varchar(250) NULL,
			note_text varchar(MAX) NOT NULL,
			encoding_concept_id integer NOT NULL,
			language_concept_id integer NOT NULL,
			provider_id integer NULL,
			visit_occurrence_id integer NULL,
			visit_detail_id integer NULL,
			note_source_value varchar(50) NULL,
			note_event_id integer NULL,
			note_event_field_concept_id integer NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE NOTE_NLP (
			note_nlp_id integer NOT NULL,
			note_id integer NOT NULL,
			section_concept_id integer NULL,
			snippet varchar(250) NULL,
			"offset" varchar(50) NULL,
			lexical_variant varchar(250) NOT NULL,
			note_nlp_concept_id integer NULL,
			note_nlp_source_concept_id integer NULL,
			nlp_system varchar(250) NULL,
			nlp_date date NOT NULL,
			nlp_datetime datetime NULL,
			term_exists varchar(1) NULL,
			term_temporal varchar(50) NULL,
			term_modifiers varchar(2000) NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE SPECIMEN (
			specimen_id integer NOT NULL,
			person_id integer NOT NULL,
			specimen_concept_id integer NOT NULL,
			specimen_type_concept_id integer NOT NULL,
			specimen_date date NOT NULL,
			specimen_datetime datetime NULL,
			quantity float NULL,
			unit_concept_id integer NULL,
			anatomic_site_concept_id integer NULL,
			disease_status_concept_id integer NULL,
			specimen_source_id varchar(50) NULL,
			specimen_source_value varchar(50) NULL,
			unit_source_value varchar(50) NULL,
			anatomic_site_source_value varchar(50) NULL,
			disease_status_source_value varchar(50) NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE FACT_RELATIONSHIP (
			domain_concept_id_1 integer NOT NULL,
			fact_id_1 integer NOT NULL,
			domain_concept_id_2 integer NOT NULL,
			fact_id_2 integer NOT NULL,
			relationship_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE LOCATION (
			location_id integer NOT NULL,
			address_1 varchar(50) NULL,
			address_2 varchar(50) NULL,
			city varchar(50) NULL,
			state varchar(2) NULL,
			zip varchar(9) NULL,
			county varchar(20) NULL,
			location_source_value varchar(50) NULL,
			country_concept_id integer NULL,
			country_source_value varchar(80) NULL,
			latitude float NULL,
			longitude float NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE CARE_SITE (
			care_site_id integer NOT NULL,
			care_site_name varchar(255) NULL,
			place_of_service_concept_id integer NULL,
			location_id integer NULL,
			care_site_source_value varchar(50) NULL,
			place_of_service_source_value varchar(50) NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE PROVIDER (
			provider_id integer NOT NULL,
			provider_name varchar(255) NULL,
			npi varchar(20) NULL,
			dea varchar(20) NULL,
			specialty_concept_id integer NULL,
			care_site_id integer NULL,
			year_of_birth integer NULL,
			gender_concept_id integer NULL,
			provider_source_value varchar(50) NULL,
			specialty_source_value varchar(50) NULL,
			specialty_source_concept_id integer NULL,
			gender_source_value varchar(50) NULL,
			gender_source_concept_id integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE PAYER_PLAN_PERIOD (
			payer_plan_period_id integer NOT NULL,
			person_id integer NOT NULL,
			payer_plan_period_start_date date NOT NULL,
			payer_plan_period_end_date date NOT NULL,
			payer_concept_id integer NULL,
			payer_source_value varchar(50) NULL,
			payer_source_concept_id integer NULL,
			plan_concept_id integer NULL,
			plan_source_value varchar(50) NULL,
			plan_source_concept_id integer NULL,
			sponsor_concept_id integer NULL,
			sponsor_source_value varchar(50) NULL,
			sponsor_source_concept_id integer NULL,
			family_source_value varchar(50) NULL,
			stop_reason_concept_id integer NULL,
			stop_reason_source_value varchar(50) NULL,
			stop_reason_source_concept_id integer NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE COST (
			cost_id integer NOT NULL,
			cost_event_id integer NOT NULL,
			cost_domain_id varchar(20) NOT NULL,
			cost_type_concept_id integer NOT NULL,
			currency_concept_id integer NULL,
			total_charge float NULL,
			total_cost float NULL,
			total_paid float NULL,
			paid_by_payer float NULL,
			paid_by_patient float NULL,
			paid_patient_copay float NULL,
			paid_patient_coinsurance float NULL,
			paid_patient_deductible float NULL,
			paid_by_primary float NULL,
			paid_ingredient_cost float NULL,
			paid_dispensing_fee float NULL,
			payer_plan_period_id integer NULL,
			amount_allowed float NULL,
			revenue_code_concept_id integer NULL,
			revenue_code_source_value varchar(50) NULL,
			drg_concept_id integer NULL,
			drg_source_value varchar(3) NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE DRUG_ERA (
			drug_era_id integer NOT NULL,
			person_id integer NOT NULL,
			drug_concept_id integer NOT NULL,
			drug_era_start_date date NOT NULL,
			drug_era_end_date date NOT NULL,
			drug_exposure_count integer NULL,
			gap_days integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE DOSE_ERA (
			dose_era_id integer NOT NULL,
			person_id integer NOT NULL,
			drug_concept_id integer NOT NULL,
			unit_concept_id integer NOT NULL,
			dose_value float NOT NULL,
			dose_era_start_date date NOT NULL,
			dose_era_end_date date NOT NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE CONDITION_ERA (
			condition_era_id integer NOT NULL,
			person_id integer NOT NULL,
			condition_concept_id integer NOT NULL,
			condition_era_start_date date NOT NULL,
			condition_era_end_date date NOT NULL,
			condition_occurrence_count integer NULL );

--HINT DISTRIBUTE ON KEY (person_id)
CREATE TABLE EPISODE (
			episode_id integer NOT NULL,
			person_id integer NOT NULL,
			episode_concept_id integer NOT NULL,
			episode_start_date date NOT NULL,
			episode_start_datetime datetime NULL,
			episode_end_date date NULL,
			episode_end_datetime datetime NULL,
			episode_parent_id integer NULL,
			episode_number integer NULL,
			episode_object_concept_id integer NOT NULL,
			episode_type_concept_id integer NOT NULL,
			episode_source_value varchar(50) NULL,
			episode_source_concept_id integer NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE EPISODE_EVENT (
			episode_id integer NOT NULL,
			event_id integer NOT NULL,
			episode_event_field_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE METADATA (
			metadata_id integer NOT NULL,
			metadata_concept_id integer NOT NULL,
			metadata_type_concept_id integer NOT NULL,
			name varchar(250) NOT NULL,
			value_as_string varchar(250) NULL,
			value_as_concept_id integer NULL,
			value_as_number float NULL,
			metadata_date date NULL,
			metadata_datetime datetime NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE CDM_SOURCE (
			cdm_source_name varchar(255) NOT NULL,
			cdm_source_abbreviation varchar(25) NOT NULL,
			cdm_holder varchar(255) NOT NULL,
			source_description varchar(MAX) NULL,
			source_documentation_reference varchar(255) NULL,
			cdm_etl_reference varchar(255) NULL,
			source_release_date date NOT NULL,
			cdm_release_date date NOT NULL,
			cdm_version varchar(10) NULL,
			cdm_version_concept_id integer NOT NULL,
			vocabulary_version varchar(20) NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE CONCEPT (
			concept_id integer NOT NULL,
			concept_name varchar(255) NOT NULL,
			domain_id varchar(20) NOT NULL,
			vocabulary_id varchar(20) NOT NULL,
			concept_class_id varchar(20) NOT NULL,
			standard_concept varchar(1) NULL,
			concept_code varchar(50) NOT NULL,
			valid_start_date date NOT NULL,
			valid_end_date date NOT NULL,
			invalid_reason varchar(1) NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE VOCABULARY (
			vocabulary_id varchar(20) NOT NULL,
			vocabulary_name varchar(255) NOT NULL,
			vocabulary_reference varchar(255) NULL,
			vocabulary_version varchar(255) NULL,
			vocabulary_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE DOMAIN (
			domain_id varchar(20) NOT NULL,
			domain_name varchar(255) NOT NULL,
			domain_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE CONCEPT_CLASS (
			concept_class_id varchar(20) NOT NULL,
			concept_class_name varchar(255) NOT NULL,
			concept_class_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE CONCEPT_RELATIONSHIP (
			concept_id_1 integer NOT NULL,
			concept_id_2 integer NOT NULL,
			relationship_id varchar(20) NOT NULL,
			valid_start_date date NOT NULL,
			valid_end_date date NOT NULL,
			invalid_reason varchar(1) NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE RELATIONSHIP (
			relationship_id varchar(20) NOT NULL,
			relationship_name varchar(255) NOT NULL,
			is_hierarchical varchar(1) NOT NULL,
			defines_ancestry varchar(1) NOT NULL,
			reverse_relationship_id varchar(20) NOT NULL,
			relationship_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE CONCEPT_SYNONYM (
			concept_id integer NOT NULL,
			concept_synonym_name varchar(1000) NOT NULL,
			language_concept_id integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE CONCEPT_ANCESTOR (
			ancestor_concept_id integer NOT NULL,
			descendant_concept_id integer NOT NULL,
			min_levels_of_separation integer NOT NULL,
			max_levels_of_separation integer NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE SOURCE_TO_CONCEPT_MAP (
			source_code varchar(50) NOT NULL,
			source_concept_id integer NOT NULL,
			source_vocabulary_id varchar(20) NOT NULL,
			source_code_description varchar(255) NULL,
			target_concept_id integer NOT NULL,
			target_vocabulary_id varchar(20) NOT NULL,
			valid_start_date date NOT NULL,
			valid_end_date date NOT NULL,
			invalid_reason varchar(1) NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE DRUG_STRENGTH (
			drug_concept_id integer NOT NULL,
			ingredient_concept_id integer NOT NULL,
			amount_value float NULL,
			amount_unit_concept_id integer NULL,
			numerator_value float NULL,
			numerator_unit_concept_id integer NULL,
			denominator_value float NULL,
			denominator_unit_concept_id integer NULL,
			box_size integer NULL,
			valid_start_date date NOT NULL,
			valid_end_date date NOT NULL,
			invalid_reason varchar(1) NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE COHORT (
			cohort_definition_id integer NOT NULL,
			subject_id integer NOT NULL,
			cohort_start_date date NOT NULL,
			cohort_end_date date NOT NULL );

--HINT DISTRIBUTE ON RANDOM
CREATE TABLE COHORT_DEFINITION (
			cohort_definition_id integer NOT NULL,
			cohort_definition_name varchar(255) NOT NULL,
			cohort_definition_description varchar(MAX) NULL,
			definition_type_concept_id integer NOT NULL,
			cohort_definition_syntax varchar(MAX) NULL,
			subject_concept_id integer NOT NULL,
			cohort_initiation_date date NULL );
GO

--sql server CDM Primary Key Constraints for OMOP Common Data Model 5.4
ALTER TABLE PERSON ADD CONSTRAINT xpk_PERSON PRIMARY KEY NONCLUSTERED (person_id);
ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT xpk_OBSERVATION_PERIOD PRIMARY KEY NONCLUSTERED (observation_period_id);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT xpk_VISIT_OCCURRENCE PRIMARY KEY NONCLUSTERED (visit_occurrence_id);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT xpk_VISIT_DETAIL PRIMARY KEY NONCLUSTERED (visit_detail_id);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT xpk_CONDITION_OCCURRENCE PRIMARY KEY NONCLUSTERED (condition_occurrence_id);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT xpk_DRUG_EXPOSURE PRIMARY KEY NONCLUSTERED (drug_exposure_id);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT xpk_PROCEDURE_OCCURRENCE PRIMARY KEY NONCLUSTERED (procedure_occurrence_id);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT xpk_DEVICE_EXPOSURE PRIMARY KEY NONCLUSTERED (device_exposure_id);
ALTER TABLE MEASUREMENT ADD CONSTRAINT xpk_MEASUREMENT PRIMARY KEY NONCLUSTERED (measurement_id);
ALTER TABLE OBSERVATION ADD CONSTRAINT xpk_OBSERVATION PRIMARY KEY NONCLUSTERED (observation_id);
ALTER TABLE NOTE ADD CONSTRAINT xpk_NOTE PRIMARY KEY NONCLUSTERED (note_id);
ALTER TABLE NOTE_NLP ADD CONSTRAINT xpk_NOTE_NLP PRIMARY KEY NONCLUSTERED (note_nlp_id);
ALTER TABLE SPECIMEN ADD CONSTRAINT xpk_SPECIMEN PRIMARY KEY NONCLUSTERED (specimen_id);
ALTER TABLE LOCATION ADD CONSTRAINT xpk_LOCATION PRIMARY KEY NONCLUSTERED (location_id);
ALTER TABLE CARE_SITE ADD CONSTRAINT xpk_CARE_SITE PRIMARY KEY NONCLUSTERED (care_site_id);
ALTER TABLE PROVIDER ADD CONSTRAINT xpk_PROVIDER PRIMARY KEY NONCLUSTERED (provider_id);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT xpk_PAYER_PLAN_PERIOD PRIMARY KEY NONCLUSTERED (payer_plan_period_id);
ALTER TABLE COST ADD CONSTRAINT xpk_COST PRIMARY KEY NONCLUSTERED (cost_id);
ALTER TABLE DRUG_ERA ADD CONSTRAINT xpk_DRUG_ERA PRIMARY KEY NONCLUSTERED (drug_era_id);
ALTER TABLE DOSE_ERA ADD CONSTRAINT xpk_DOSE_ERA PRIMARY KEY NONCLUSTERED (dose_era_id);
ALTER TABLE CONDITION_ERA ADD CONSTRAINT xpk_CONDITION_ERA PRIMARY KEY NONCLUSTERED (condition_era_id);
ALTER TABLE EPISODE ADD CONSTRAINT xpk_EPISODE PRIMARY KEY NONCLUSTERED (episode_id);
ALTER TABLE METADATA ADD CONSTRAINT xpk_METADATA PRIMARY KEY NONCLUSTERED (metadata_id);
ALTER TABLE CONCEPT ADD CONSTRAINT xpk_CONCEPT PRIMARY KEY NONCLUSTERED (concept_id);
ALTER TABLE VOCABULARY ADD CONSTRAINT xpk_VOCABULARY PRIMARY KEY NONCLUSTERED (vocabulary_id);
ALTER TABLE DOMAIN ADD CONSTRAINT xpk_DOMAIN PRIMARY KEY NONCLUSTERED (domain_id);
ALTER TABLE CONCEPT_CLASS ADD CONSTRAINT xpk_CONCEPT_CLASS PRIMARY KEY NONCLUSTERED (concept_class_id);
ALTER TABLE RELATIONSHIP ADD CONSTRAINT xpk_RELATIONSHIP PRIMARY KEY NONCLUSTERED (relationship_id);
GO

/*sql server OMOP CDM Indices
  There are no unique indices created because it is assumed that the primary key constraints have been run prior to
  implementing indices.
*/
/************************
Standardized clinical data
************************/
CREATE CLUSTERED INDEX idx_person_id ON person (person_id ASC);
CREATE INDEX idx_gender ON person (gender_concept_id ASC);
CREATE CLUSTERED INDEX idx_observation_period_id_1 ON observation_period (person_id ASC);
CREATE CLUSTERED INDEX idx_visit_person_id_1 ON visit_occurrence (person_id ASC);
CREATE INDEX idx_visit_concept_id_1 ON visit_occurrence (visit_concept_id ASC);
CREATE CLUSTERED INDEX idx_visit_det_person_id_1 ON visit_detail (person_id ASC);
CREATE INDEX idx_visit_det_concept_id_1 ON visit_detail (visit_detail_concept_id ASC);
CREATE INDEX idx_visit_det_occ_id ON visit_detail (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_condition_person_id_1 ON condition_occurrence (person_id ASC);
CREATE INDEX idx_condition_concept_id_1 ON condition_occurrence (condition_concept_id ASC);
CREATE INDEX idx_condition_visit_id_1 ON condition_occurrence (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_drug_person_id_1 ON drug_exposure (person_id ASC);
CREATE INDEX idx_drug_concept_id_1 ON drug_exposure (drug_concept_id ASC);
CREATE INDEX idx_drug_visit_id_1 ON drug_exposure (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_procedure_person_id_1 ON procedure_occurrence (person_id ASC);
CREATE INDEX idx_procedure_concept_id_1 ON procedure_occurrence (procedure_concept_id ASC);
CREATE INDEX idx_procedure_visit_id_1 ON procedure_occurrence (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_device_person_id_1 ON device_exposure (person_id ASC);
CREATE INDEX idx_device_concept_id_1 ON device_exposure (device_concept_id ASC);
CREATE INDEX idx_device_visit_id_1 ON device_exposure (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_measurement_person_id_1 ON measurement (person_id ASC);
CREATE INDEX idx_measurement_concept_id_1 ON measurement (measurement_concept_id ASC);
CREATE INDEX idx_measurement_visit_id_1 ON measurement (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_observation_person_id_1 ON observation (person_id ASC);
CREATE INDEX idx_observation_concept_id_1 ON observation (observation_concept_id ASC);
CREATE INDEX idx_observation_visit_id_1 ON observation (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_death_person_id_1 ON death (person_id ASC);
CREATE CLUSTERED INDEX idx_note_person_id_1 ON note (person_id ASC);
CREATE INDEX idx_note_concept_id_1 ON note (note_type_concept_id ASC);
CREATE INDEX idx_note_visit_id_1 ON note (visit_occurrence_id ASC);
CREATE CLUSTERED INDEX idx_note_nlp_note_id_1 ON note_nlp (note_id ASC);
CREATE INDEX idx_note_nlp_concept_id_1 ON note_nlp (note_nlp_concept_id ASC);
CREATE CLUSTERED INDEX idx_specimen_person_id_1 ON specimen (person_id ASC);
CREATE INDEX idx_specimen_concept_id_1 ON specimen (specimen_concept_id ASC);
CREATE INDEX idx_fact_relationship_id1 ON fact_relationship (domain_concept_id_1 ASC);
CREATE INDEX idx_fact_relationship_id2 ON fact_relationship (domain_concept_id_2 ASC);
CREATE INDEX idx_fact_relationship_id3 ON fact_relationship (relationship_concept_id ASC);
/************************
Standardized health system data
************************/
CREATE CLUSTERED INDEX idx_location_id_1 ON location (location_id ASC);
CREATE CLUSTERED INDEX idx_care_site_id_1 ON care_site (care_site_id ASC);
CREATE CLUSTERED INDEX idx_provider_id_1 ON provider (provider_id ASC);
/************************
Standardized health economics
************************/
CREATE CLUSTERED INDEX idx_period_person_id_1 ON payer_plan_period (person_id ASC);
CREATE INDEX idx_cost_event_id  ON cost (cost_event_id ASC);
/************************
Standardized derived elements
************************/
CREATE CLUSTERED INDEX idx_drug_era_person_id_1 ON drug_era (person_id ASC);
CREATE INDEX idx_drug_era_concept_id_1 ON drug_era (drug_concept_id ASC);
CREATE CLUSTERED INDEX idx_dose_era_person_id_1 ON dose_era (person_id ASC);
CREATE INDEX idx_dose_era_concept_id_1 ON dose_era (drug_concept_id ASC);
CREATE CLUSTERED INDEX idx_condition_era_person_id_1 ON condition_era (person_id ASC);
CREATE INDEX idx_condition_era_concept_id_1 ON condition_era (condition_concept_id ASC);
/**************************
Standardized meta-data
***************************/
CREATE CLUSTERED INDEX idx_metadata_concept_id_1 ON metadata (metadata_concept_id ASC);
/**************************
Standardized vocabularies
***************************/
CREATE CLUSTERED INDEX idx_concept_concept_id ON concept (concept_id ASC);
CREATE INDEX idx_concept_code ON concept (concept_code ASC);
CREATE INDEX idx_concept_vocabluary_id ON concept (vocabulary_id ASC);
CREATE INDEX idx_concept_domain_id ON concept (domain_id ASC);
CREATE INDEX idx_concept_class_id ON concept (concept_class_id ASC);
CREATE CLUSTERED INDEX idx_vocabulary_vocabulary_id ON vocabulary (vocabulary_id ASC);
CREATE CLUSTERED INDEX idx_domain_domain_id ON domain (domain_id ASC);
CREATE CLUSTERED INDEX idx_concept_class_class_id ON concept_class (concept_class_id ASC);
CREATE CLUSTERED INDEX idx_concept_relationship_id_1 ON concept_relationship (concept_id_1 ASC);
CREATE INDEX idx_concept_relationship_id_2 ON concept_relationship (concept_id_2 ASC);
CREATE INDEX idx_concept_relationship_id_3 ON concept_relationship (relationship_id ASC);
CREATE CLUSTERED INDEX idx_relationship_rel_id ON relationship (relationship_id ASC);
CREATE CLUSTERED INDEX idx_concept_synonym_id ON concept_synonym (concept_id ASC);
CREATE CLUSTERED INDEX idx_concept_ancestor_id_1 ON concept_ancestor (ancestor_concept_id ASC);
CREATE INDEX idx_concept_ancestor_id_2 ON concept_ancestor (descendant_concept_id ASC);
CREATE CLUSTERED INDEX idx_source_to_concept_map_3 ON source_to_concept_map (target_concept_id ASC);
CREATE INDEX idx_source_to_concept_map_1 ON source_to_concept_map (source_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_2 ON source_to_concept_map (target_vocabulary_id ASC);
CREATE INDEX idx_source_to_concept_map_c ON source_to_concept_map (source_code ASC);
CREATE CLUSTERED INDEX idx_drug_strength_id_1 ON drug_strength (drug_concept_id ASC);
CREATE INDEX idx_drug_strength_id_2 ON drug_strength (ingredient_concept_id ASC);
GO

--sql server CDM Foreign Key Constraints for OMOP Common Data Model 5.4
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_gender_concept_id FOREIGN KEY (gender_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_race_concept_id FOREIGN KEY (race_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_ethnicity_concept_id FOREIGN KEY (ethnicity_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_location_id FOREIGN KEY (location_id) REFERENCES LOCATION (LOCATION_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_gender_source_concept_id FOREIGN KEY (gender_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_race_source_concept_id FOREIGN KEY (race_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PERSON ADD CONSTRAINT fpk_PERSON_ethnicity_source_concept_id FOREIGN KEY (ethnicity_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT fpk_OBSERVATION_PERIOD_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT fpk_OBSERVATION_PERIOD_period_type_concept_id FOREIGN KEY (period_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_visit_concept_id FOREIGN KEY (visit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_visit_type_concept_id FOREIGN KEY (visit_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_visit_source_concept_id FOREIGN KEY (visit_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_admitted_from_concept_id FOREIGN KEY (admitted_from_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_discharged_to_concept_id FOREIGN KEY (discharged_to_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT fpk_VISIT_OCCURRENCE_preceding_visit_occurrence_id FOREIGN KEY (preceding_visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_detail_concept_id FOREIGN KEY (visit_detail_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_detail_type_concept_id FOREIGN KEY (visit_detail_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_detail_source_concept_id FOREIGN KEY (visit_detail_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_admitted_from_concept_id FOREIGN KEY (admitted_from_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_discharged_to_concept_id FOREIGN KEY (discharged_to_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_preceding_visit_detail_id FOREIGN KEY (preceding_visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_parent_visit_detail_id FOREIGN KEY (parent_visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE VISIT_DETAIL ADD CONSTRAINT fpk_VISIT_DETAIL_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_concept_id FOREIGN KEY (condition_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_type_concept_id FOREIGN KEY (condition_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_status_concept_id FOREIGN KEY (condition_status_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT fpk_CONDITION_OCCURRENCE_condition_source_concept_id FOREIGN KEY (condition_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_drug_type_concept_id FOREIGN KEY (drug_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_route_concept_id FOREIGN KEY (route_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT fpk_DRUG_EXPOSURE_drug_source_concept_id FOREIGN KEY (drug_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_procedure_concept_id FOREIGN KEY (procedure_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_procedure_type_concept_id FOREIGN KEY (procedure_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_modifier_concept_id FOREIGN KEY (modifier_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT fpk_PROCEDURE_OCCURRENCE_procedure_source_concept_id FOREIGN KEY (procedure_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_device_concept_id FOREIGN KEY (device_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_device_type_concept_id FOREIGN KEY (device_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_device_source_concept_id FOREIGN KEY (device_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEVICE_EXPOSURE ADD CONSTRAINT fpk_DEVICE_EXPOSURE_unit_source_concept_id FOREIGN KEY (unit_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_measurement_concept_id FOREIGN KEY (measurement_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_measurement_type_concept_id FOREIGN KEY (measurement_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_operator_concept_id FOREIGN KEY (operator_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_value_as_concept_id FOREIGN KEY (value_as_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_measurement_source_concept_id FOREIGN KEY (measurement_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_unit_source_concept_id FOREIGN KEY (unit_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE MEASUREMENT ADD CONSTRAINT fpk_MEASUREMENT_meas_event_field_concept_id FOREIGN KEY (meas_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_observation_concept_id FOREIGN KEY (observation_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_observation_type_concept_id FOREIGN KEY (observation_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_value_as_concept_id FOREIGN KEY (value_as_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_qualifier_concept_id FOREIGN KEY (qualifier_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_observation_source_concept_id FOREIGN KEY (observation_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE OBSERVATION ADD CONSTRAINT fpk_OBSERVATION_obs_event_field_concept_id FOREIGN KEY (obs_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_death_type_concept_id FOREIGN KEY (death_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_cause_concept_id FOREIGN KEY (cause_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DEATH ADD CONSTRAINT fpk_DEATH_cause_source_concept_id FOREIGN KEY (cause_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_note_type_concept_id FOREIGN KEY (note_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_note_class_concept_id FOREIGN KEY (note_class_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_encoding_concept_id FOREIGN KEY (encoding_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_language_concept_id FOREIGN KEY (language_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_provider_id FOREIGN KEY (provider_id) REFERENCES PROVIDER (PROVIDER_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_visit_occurrence_id FOREIGN KEY (visit_occurrence_id) REFERENCES VISIT_OCCURRENCE (VISIT_OCCURRENCE_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_visit_detail_id FOREIGN KEY (visit_detail_id) REFERENCES VISIT_DETAIL (VISIT_DETAIL_ID);
ALTER TABLE NOTE ADD CONSTRAINT fpk_NOTE_note_event_field_concept_id FOREIGN KEY (note_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE_NLP ADD CONSTRAINT fpk_NOTE_NLP_section_concept_id FOREIGN KEY (section_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE_NLP ADD CONSTRAINT fpk_NOTE_NLP_note_nlp_concept_id FOREIGN KEY (note_nlp_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE NOTE_NLP ADD CONSTRAINT fpk_NOTE_NLP_note_nlp_source_concept_id FOREIGN KEY (note_nlp_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_specimen_concept_id FOREIGN KEY (specimen_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_specimen_type_concept_id FOREIGN KEY (specimen_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_anatomic_site_concept_id FOREIGN KEY (anatomic_site_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SPECIMEN ADD CONSTRAINT fpk_SPECIMEN_disease_status_concept_id FOREIGN KEY (disease_status_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE FACT_RELATIONSHIP ADD CONSTRAINT fpk_FACT_RELATIONSHIP_domain_concept_id_1 FOREIGN KEY (domain_concept_id_1) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE FACT_RELATIONSHIP ADD CONSTRAINT fpk_FACT_RELATIONSHIP_domain_concept_id_2 FOREIGN KEY (domain_concept_id_2) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE FACT_RELATIONSHIP ADD CONSTRAINT fpk_FACT_RELATIONSHIP_relationship_concept_id FOREIGN KEY (relationship_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE LOCATION ADD CONSTRAINT fpk_LOCATION_country_concept_id FOREIGN KEY (country_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CARE_SITE ADD CONSTRAINT fpk_CARE_SITE_place_of_service_concept_id FOREIGN KEY (place_of_service_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CARE_SITE ADD CONSTRAINT fpk_CARE_SITE_location_id FOREIGN KEY (location_id) REFERENCES LOCATION (LOCATION_ID);
ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_specialty_concept_id FOREIGN KEY (specialty_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_care_site_id FOREIGN KEY (care_site_id) REFERENCES CARE_SITE (CARE_SITE_ID);
ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_gender_concept_id FOREIGN KEY (gender_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_specialty_source_concept_id FOREIGN KEY (specialty_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PROVIDER ADD CONSTRAINT fpk_PROVIDER_gender_source_concept_id FOREIGN KEY (gender_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_payer_concept_id FOREIGN KEY (payer_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_payer_source_concept_id FOREIGN KEY (payer_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_plan_concept_id FOREIGN KEY (plan_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_plan_source_concept_id FOREIGN KEY (plan_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_sponsor_concept_id FOREIGN KEY (sponsor_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_sponsor_source_concept_id FOREIGN KEY (sponsor_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_stop_reason_concept_id FOREIGN KEY (stop_reason_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT fpk_PAYER_PLAN_PERIOD_stop_reason_source_concept_id FOREIGN KEY (stop_reason_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE COST ADD CONSTRAINT fpk_COST_cost_domain_id FOREIGN KEY (cost_domain_id) REFERENCES DOMAIN (DOMAIN_ID);
ALTER TABLE COST ADD CONSTRAINT fpk_COST_cost_type_concept_id FOREIGN KEY (cost_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE COST ADD CONSTRAINT fpk_COST_currency_concept_id FOREIGN KEY (currency_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE COST ADD CONSTRAINT fpk_COST_revenue_code_concept_id FOREIGN KEY (revenue_code_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE COST ADD CONSTRAINT fpk_COST_drg_concept_id FOREIGN KEY (drg_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_ERA ADD CONSTRAINT fpk_DRUG_ERA_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE DRUG_ERA ADD CONSTRAINT fpk_DRUG_ERA_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DOSE_ERA ADD CONSTRAINT fpk_DOSE_ERA_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE DOSE_ERA ADD CONSTRAINT fpk_DOSE_ERA_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DOSE_ERA ADD CONSTRAINT fpk_DOSE_ERA_unit_concept_id FOREIGN KEY (unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONDITION_ERA ADD CONSTRAINT fpk_CONDITION_ERA_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE CONDITION_ERA ADD CONSTRAINT fpk_CONDITION_ERA_condition_concept_id FOREIGN KEY (condition_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_person_id FOREIGN KEY (person_id) REFERENCES PERSON (PERSON_ID);
ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_concept_id FOREIGN KEY (episode_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_object_concept_id FOREIGN KEY (episode_object_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_type_concept_id FOREIGN KEY (episode_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE EPISODE ADD CONSTRAINT fpk_EPISODE_episode_source_concept_id FOREIGN KEY (episode_source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE EPISODE_EVENT ADD CONSTRAINT fpk_EPISODE_EVENT_episode_id FOREIGN KEY (episode_id) REFERENCES EPISODE (EPISODE_ID);
ALTER TABLE EPISODE_EVENT ADD CONSTRAINT fpk_EPISODE_EVENT_episode_event_field_concept_id FOREIGN KEY (episode_event_field_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE METADATA ADD CONSTRAINT fpk_METADATA_metadata_concept_id FOREIGN KEY (metadata_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE METADATA ADD CONSTRAINT fpk_METADATA_metadata_type_concept_id FOREIGN KEY (metadata_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE METADATA ADD CONSTRAINT fpk_METADATA_value_as_concept_id FOREIGN KEY (value_as_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CDM_SOURCE ADD CONSTRAINT fpk_CDM_SOURCE_cdm_version_concept_id FOREIGN KEY (cdm_version_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT ADD CONSTRAINT fpk_CONCEPT_domain_id FOREIGN KEY (domain_id) REFERENCES DOMAIN (DOMAIN_ID);
ALTER TABLE CONCEPT ADD CONSTRAINT fpk_CONCEPT_vocabulary_id FOREIGN KEY (vocabulary_id) REFERENCES VOCABULARY (VOCABULARY_ID);
ALTER TABLE CONCEPT ADD CONSTRAINT fpk_CONCEPT_concept_class_id FOREIGN KEY (concept_class_id) REFERENCES CONCEPT_CLASS (CONCEPT_CLASS_ID);
ALTER TABLE VOCABULARY ADD CONSTRAINT fpk_VOCABULARY_vocabulary_concept_id FOREIGN KEY (vocabulary_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DOMAIN ADD CONSTRAINT fpk_DOMAIN_domain_concept_id FOREIGN KEY (domain_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_CLASS ADD CONSTRAINT fpk_CONCEPT_CLASS_concept_class_concept_id FOREIGN KEY (concept_class_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_RELATIONSHIP ADD CONSTRAINT fpk_CONCEPT_RELATIONSHIP_concept_id_1 FOREIGN KEY (concept_id_1) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_RELATIONSHIP ADD CONSTRAINT fpk_CONCEPT_RELATIONSHIP_concept_id_2 FOREIGN KEY (concept_id_2) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_RELATIONSHIP ADD CONSTRAINT fpk_CONCEPT_RELATIONSHIP_relationship_id FOREIGN KEY (relationship_id) REFERENCES RELATIONSHIP (RELATIONSHIP_ID);
ALTER TABLE RELATIONSHIP ADD CONSTRAINT fpk_RELATIONSHIP_relationship_concept_id FOREIGN KEY (relationship_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_SYNONYM ADD CONSTRAINT fpk_CONCEPT_SYNONYM_concept_id FOREIGN KEY (concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_SYNONYM ADD CONSTRAINT fpk_CONCEPT_SYNONYM_language_concept_id FOREIGN KEY (language_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_ANCESTOR ADD CONSTRAINT fpk_CONCEPT_ANCESTOR_ancestor_concept_id FOREIGN KEY (ancestor_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE CONCEPT_ANCESTOR ADD CONSTRAINT fpk_CONCEPT_ANCESTOR_descendant_concept_id FOREIGN KEY (descendant_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SOURCE_TO_CONCEPT_MAP ADD CONSTRAINT fpk_SOURCE_TO_CONCEPT_MAP_source_concept_id FOREIGN KEY (source_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SOURCE_TO_CONCEPT_MAP ADD CONSTRAINT fpk_SOURCE_TO_CONCEPT_MAP_target_concept_id FOREIGN KEY (target_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE SOURCE_TO_CONCEPT_MAP ADD CONSTRAINT fpk_SOURCE_TO_CONCEPT_MAP_target_vocabulary_id FOREIGN KEY (target_vocabulary_id) REFERENCES VOCABULARY (VOCABULARY_ID);
ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_drug_concept_id FOREIGN KEY (drug_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_ingredient_concept_id FOREIGN KEY (ingredient_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_amount_unit_concept_id FOREIGN KEY (amount_unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_numerator_unit_concept_id FOREIGN KEY (numerator_unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE DRUG_STRENGTH ADD CONSTRAINT fpk_DRUG_STRENGTH_denominator_unit_concept_id FOREIGN KEY (denominator_unit_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE COHORT_DEFINITION ADD CONSTRAINT fpk_COHORT_DEFINITION_definition_type_concept_id FOREIGN KEY (definition_type_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
ALTER TABLE COHORT_DEFINITION ADD CONSTRAINT fpk_COHORT_DEFINITION_subject_concept_id FOREIGN KEY (subject_concept_id) REFERENCES CONCEPT (CONCEPT_ID);
GO
