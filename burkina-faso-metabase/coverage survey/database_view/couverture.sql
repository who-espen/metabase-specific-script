create view v_espen_bf_lf_cov_2_couverture_202211_v2 as

SELECT 

id,
code_enqueteur "Opérateur", 
district "District",
code_grappe "Code Grappe",
numero_menage "Num. Ménage",
numero_enquete "Numéro Enqueté", 
code_enquete "Code Enqueté",
repondant "Répondant", 
enquete_present "Etait présent",
age "Age (Années)", 
age_en_mois "Age (Mois)", 
sexe "Sexe", 
etude "Niveau Etude", 
duree_sejour "Durée Séjour", 
recu_ivm "A reçu IVM", 
pourquoi_pas_recu_ivm "Pourquoi n'a pas reçu IVM",
raisons_absence "Raison Absence", 
autre_traitement "Autre traitement", 
lieu_autrement_traitement "Lieu Autre Traitement",
avale_ivm "A Avalé IVM", 
nb_comp_avale "Nbr Comp. Avalé", 
prise_supervisee "Prise Supervisé", 
pourquoi_avale "Pourquoi Avalé",
pourquoi_pas_avale "Pourquoi pas Avalé",
lieux "Lieu",
prise_taille "Prise Taille", 
effet_indesirable "Effet Indésirable",
type_effet_indesirable "Type Effet Indésirable",
autre_effet_indesirable "Autre Effet indésirable",
combien_de_temps "Combien de temps",
nb_ivm_avale "Nb IVM Avalé", 
jamais_ivm "Jamais IVM", 
autres_raisons "Autres Raison",
taille "Taille",
traitementparlequipe "Traitement par l'Equipe",
notes "Note", 
debut_edition "Date"

FROM public.espen_bf_lf_cov_2_couverture_202211_v2 c

