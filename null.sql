SELECT 
track_name,
artist_s__name,
COUNT(*) AS  quantidade
FROM `hip-caster-419814.conj_dados_proj2.track_in_spotify`
GROUP BY track_name, artist_s__name
HAVING COUNT(*) > 1