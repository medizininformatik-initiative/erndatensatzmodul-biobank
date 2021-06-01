Alias: $SCT = http://snomed.info/sct

Profile: ProfileSpecimenBioprobe
Parent: http://hl7.org/fhir/StructureDefinition/Specimen
Id: ProfileSpecimenBioprobe
Title: "Profile - Specimen- Bioprobe"
Description: "Abbildung einer MII Bioprobe"

* identifier and type and container.specimenQuantity and status and note and parent and container.type and container.capacity 
and container.additive[x] and collection.collected[x] and collection.bodySite and collection.fastingStatus[x] 
and processing.timePeriod and processing.procedure and processing.additive MS

//Bioprobe

* extension contains ExtensionDiagnose named diagnose 0..1 MS and ExtensionVerwaltendeOrganisation named gehoertZu 1..1 MS

* type.coding ^slicing.discriminator.type = #pattern
* type.coding ^slicing.discriminator.path = "system"
* type.coding ^slicing.rules = #open

* type.coding contains sct 1..*
* type.coding[sct] from ValueSetProbenart (extensible)
* type.coding[sct].system = $SCT

//Primärcontainer

* container.type from ValueSetContainertyp (extensible)

//Additiv: Wie ja/nein? Substance vs CodeableConcept? Profile auf Substance?
* container.additiveCodeableConcept from ValueSetAdditive (extensible)
* container.additiveReference only Reference(ProfileSubstanceAdditiv)

//Probenentnahme -> Entnahme-ID?

* collection.extension contains ExtensionEinstellungBlutversorgung named einstellungBlutversorgung 0..1 MS

* collection.fastingStatusCodeableConcept from 	http://terminology.hl7.org/ValueSet/v2-0916 (required)

* collection.bodySite.coding ^slicing.discriminator.type = #pattern
* collection.bodySite.coding ^slicing.discriminator.path = "system"
* collection.bodySite.coding ^slicing.rules = #open

* collection.bodySite.coding contains sct 0..1 MS and icd-o-3 0..1 MS

* collection.bodySite.coding[sct] from ValueSetSCTBodyStructures (required)
* collection.bodySite.coding[sct].system = $SCT
//TODO ICD-O-3 + constraint sct oder icd-O-3

//Verarbeitung/Lagerprozess

* processing.extension contains ExtensionTemperaturbedingungen named temperaturbedingungen 0..1 MS
* processing.procedure 1..1
* processing.time[x] 1..1
* processing.timePeriod.start 1..1
* processing.additive only Reference(ProfileSubstanceAdditiv)

* processing ^slicing.discriminator.type = #pattern
* processing ^slicing.discriminator.path = "processing.procedure.coding"
* processing ^slicing.rules = #open

* processing contains lagerprozess 0..* MS
* processing[lagerprozess].procedure.coding = $SCT#69997009 "Specimen refrigeration (procedure)" //TODO Besseren Code finden

ValueSet: ValueSetProbenart
Id: ValueSetProbenart
Title: "ValueSet - Probenart"

* include codes from system $SCT where concept descendent-of #123038009

ValueSet: ValueSetContainertyp
Id: ValueSetContainertyp
Title: "ValueSet - Containertyp"

* include codes from system $SCT where concept descendent-of #706041008

ValueSet: ValueSetAdditive
Id: ValueSetAdditive
Title: "ValueSet - Additive"

* include codes from system $SCT where concept descendent-of #105590001

ValueSet: ValueSetSCTBodyStructures
Id: ValueSetSCTBodyStructures
Title: "ValueSet - SNOMED CT Body Strutures"

* include codes from system $SCT where concept descendent-of #123037004

CodeSystem: CodeSystemCentrifugationSPREC
Id: CodeSystemCentrifugationSPREC
Title: "CodeSystem - SPREC Zentrifugation"

* ^valueSet = "https://www.medizininformatik-initiative.de/fhir/ext/modul-biobank/ValueSet/CentrifugationSPREC"

* #A "RT 10–15 min <3000 g no braking"
* #B "RT 10–15 min <3000 g with braking"
* #C "2°C–10°C 10–15 min <3000 g no braking"
* #D "2°C–10°C 10–15 min <3000 g with braking"
* #E "RT 10–15 min 3000–6000 g with braking"
* #F "2°C–10°C 10–15 min 3000–6000 g with braking"
* #G "RT 10–15 min6000–10000 g with braking"
* #H "2°C–10°C 10–15 min 6000–10000 g with braking"
* #I "RT 10–15 min >10000 g with braking"
* #J "2°C–10°C 10–15 min>10000 g with braking"
* #M "RT 30 min <1000 g no braking"
* #N "No centrifugation"
* #X "Unknown"
* #Z "Other"


//ICD-O-3 Topography ValueSet TODO

Extension: ExtensionDiagnose
Id: ExtensionDiagnose
Title: "Extension - Diagnose"

* value[x] only Reference(Condition)

Extension: ExtensionVerwaltendeOrganisation
Id: ExtensionVerwaltendeOrganisation
Title: "Extension - Verwaltende Organisation"

* value[x] only Reference(Organization)

Extension: ExtensionEinstellungBlutversorgung
Id: ExtensionEinstellungBlutversorgung
Title: "Extension - Einstellung Blutversorgung"

* value[x] only dateTime

Extension: ExtensionTemperaturbedingungen
Id: ExtensionTemperaturbedingungen
Title: "Extension - Temperaturbedingungen"

* value[x] only Range
* valueRange.low ^patternQuantity.system = "http://unitsofmeasure.org"
* valueRange.low ^patternQuantity.code = #Cel
* valueRange.low ^patternQuantity.unit = "C"
* valueRange.high ^patternQuantity.system = "http://unitsofmeasure.org"
* valueRange.high ^patternQuantity.code = #Cel
* valueRange.high ^patternQuantity.unit = "C"


Profile: ProfileSubstanceAdditiv
Parent: http://hl7.org/fhir/StructureDefinition/Substance
Id: ProfileSubstanceAdditiv
Title: "Profile - Substance - Additiv"
Description: "Abbildung eines Additives, das zu einer Probe hinzugefügt werden kann"

* code from ValueSetAdditive (extensible)
* code MS

Profile: ProfileOrganizationSammlungBiobank
Parent: http://hl7.org/fhir/StructureDefinition/Organization
Id: ProfileOrganizationSammlungBiobank
Title: "Profile - Organization - Sammlung/Biobank"
Description: "Darstellung der organisatorischen Daten einer Probensammlung oder Biobank."

* identifier and type and name and alias and partOf and contact and contact.purpose and contact.name and contact.telecom and contact.address MS //Beschreibung?

* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open

* identifier contains bbmri-eric-id 0..1 MS

* identifier[bbmri-eric-id] ^patternIdentifier.system = "http://www.bbmri-eric.eu/"

* type from https://www.medizininformatik-initiative.de/fhir/ext/modul-biobank/ValueSet/BBMRICollectionType (extensible) //?

* contact 1..*
* contact.purpose 1..1
* contact.name.family 1..1
* contact.name.given 1..*

* contact.telecom ^slicing.discriminator.type = #pattern
* contact.telecom ^slicing.discriminator.path = "system"
* contact.telecom ^slicing.rules = #open

* contact.telecom contains email 1..*
* contact.telecom[email].system = #email

* contact.address 1..1




CodeSystem: CodeSystemBBMRICollectionType
Id: CodeSystemBBMRICollectionType
Title: "CodeSystem - BBMRI Collection Type"

* ^valueSet = "https://www.medizininformatik-initiative.de/fhir/ext/modul-biobank/ValueSet/BBMRICollectionType"

* #SAMPLE	"Sample collection"
* #TWIN_STUDY	"Twin-study"
* #RD	"Rare disease collection"
* #NON_HUMAN	"Non-human"
* #BIRTH_COHORT	"Birth cohort"
* #CASE_CONTROL	"Case-Control"
* #COHORT	"Cohort"
* #CROSS_SECTIONAL	"Cross-Sectional"
* #DISEASE_SPECIFIC	"Disease specific"
* #HOSPITAL	"Hospital"
* #IMAGE	"Image collection"
* #LONGITUDINAL	"Longitudinal"
* #OTHER	"other"
* #POPULATION_BASED	"Population-based"
* #QUALITY_CONTROL	"Quality control"