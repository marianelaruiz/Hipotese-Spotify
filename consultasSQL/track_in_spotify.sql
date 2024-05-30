-- Duplicados tabela track_in_spotify
SELECT 
track_name,
artist_s__name,
COUNT(*) AS  quantidade
FROM `hip-caster-419814.conj_dados_proj2.track_in_spotify`
GROUP BY track_name, artist_s__name
HAVING COUNT(*) > 1

-- Null tabela track_in_spotify
SELECT
  COUNT(CASE WHEN track_id IS NULL THEN 1 END) AS track_id,
  COUNT(CASE WHEN track_name IS NULL THEN 1 END) AS track_name,
  COUNT(CASE WHEN artist_s__name IS NULL THEN 1 END) AS artist_s__name,
  COUNT(CASE WHEN artist_count IS NULL THEN 1 END) AS artist_count,
  COUNT(CASE WHEN released_year IS NULL THEN 1 END) AS released_year,
  COUNT(CASE WHEN released_month IS NULL THEN 1 END) AS released_month,
  COUNT(CASE WHEN released_day IS NULL THEN 1 END) AS released_day,
  COUNT(CASE WHEN in_spotify_playlists IS NULL THEN 1 END) AS in_spotify_playlists,
  COUNT(CASE WHEN in_spotify_charts IS NULL THEN 1 END) AS in_spotify_charts,
  COUNT(CASE WHEN streams IS NULL THEN 1 END) AS streams
  
  
FROM `hip-caster-419814.conj_dados_proj2.track_in_spotify`

-- Formula para countar os valores nulos de cada coluna
-- Verificou-se que a coluna "key" tem 95 valores nulos.
SELECT
  COUNT(CASE WHEN track_id IS NULL THEN 1 END) AS track_id,
  COUNT(CASE WHEN bpm IS NULL THEN 1 END) AS bpm,
  COUNT(CASE WHEN key IS NULL THEN 1 END) AS key,
  COUNT(CASE WHEN mode IS NULL THEN 1 END) AS mode,
  COUNT(CASE WHEN danceability__ IS NULL THEN 1 END) AS danceability__,
  COUNT(CASE WHEN valence__ IS NULL THEN 1 END) AS valence__,
  COUNT(CASE WHEN energy__ IS NULL THEN 1 END) AS energy__,
  COUNT(CASE WHEN acousticness__ IS NULL THEN 1 END) AS acousticness__,
  COUNT(CASE WHEN instrumentalness__ IS NULL THEN 1 END) AS instrumentalness__,
  COUNT(CASE WHEN liveness__ IS NULL THEN 1 END) AS liveness__,
  COUNT(CASE WHEN speechiness__ IS NULL THEN 1 END) AS speechiness__

FROM `hip-caster-419814.conj_dados_proj2.track_technical_info`


-- Formula para eliminar los caracteres especiales y los duplicados de las variables track_name y artist_name
SELECT 
MAX(track_id) AS track_id, 
LOWER(REGEXP_REPLACE(track_name, r'[^a-zA-Z0-9 ]', '')) AS track_name_clean,
LOWER(REGEXP_REPLACE(artist_s__name, r'[^a-zA-Z0-9 ]', '')) AS artist_s__name_clean,
artist_count, 
released_year, 
MAX(released_month) AS released_month ,
MAX(released_day) AS released_day, 
MAX(in_spotify_playlists) AS in_spotify_playlists, 
MAX(in_spotify_charts) AS in_spotify_charts, 
MAX(streams) AS streams,  
FROM `hip-caster-419814.conj_dados_proj2.track_in_spotify`
GROUP BY track_name, artist_s__name, artist_count, released_year


-- Fórmula para excluir o registro de texto na coluna 'streams' 
-- e renomear o registro na coluna 'track_id" de 0:00 a 1001427 para que seja um número exclusivo de 7 dígitos.
/*SELECT 
  CASE
      WHEN track_id = '0:00' THEN '1001427'
      ELSE track_id
  END AS track_id_atualizado,
  track_name_clean, artist_s__name_clean, artist_count, released_year, released_month, released_day, 
  in_spotify_playlists, in_spotify_charts,
  CAST(streams AS INT64) AS streams  
FROM `hip-caster-419814.conj_dados_proj2.track_in_spotify_not_duplicated_caracteres `
WHERE SAFE_CAST(streams AS INT64) IS NOT NULL;
*/


SELECT 
  CASE
      WHEN track_id = '0:00' THEN '1001427'
      ELSE track_id
  END AS track_id_atualizado,
  IF(track_name_clean = '', 'Não identificado', track_name_clean) AS track_name_clean, 
  artist_s__name_clean, artist_count, released_year,released_month,released_day,
  DATE(CONCAT(released_year, "-",released_month,"-", released_day)) AS data_de_lancamento,
  in_spotify_playlists, in_spotify_charts,  
  CAST(streams AS INT64) AS streams  
FROM `hip-caster-419814.conj_dados_proj2.track_in_spotify_not_duplicated_caracteres `
WHERE SAFE_CAST(streams AS INT64) IS NOT NULL;



