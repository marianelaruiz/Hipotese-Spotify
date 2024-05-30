---- Fórmula que traz todas as colunas, exceto "key" e "mode".
SELECT 
  CASE
      WHEN track_id = '0:00' THEN '1001427'
      ELSE track_id
  END AS track_id_atualizado,
  bpm, danceability__, valence__, energy__, acousticness__, instrumentalness__, liveness__, speechiness__
  --EXCEPT(key, mode, track_id)
FROM `hip-caster-419814.conj_dados_proj2.track_technical_info`

