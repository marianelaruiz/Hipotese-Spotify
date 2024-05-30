-------- Esta formula conta si cada coluna tem valores nulos: 
-------- Verificou-se que a coluna "in_shazam_charts" tem 50 valores nulos.
SELECT
  COUNT(CASE WHEN track_id IS NULL THEN 1 END) AS track_id,
  COUNT(CASE WHEN in_apple_playlists IS NULL THEN 1 END) AS in_apple_playlists,
  COUNT(CASE WHEN in_apple_charts IS NULL THEN 1 END) AS in_apple_charts,
  COUNT(CASE WHEN in_deezer_playlists IS NULL THEN 1 END) AS in_deezer_playlists,
  COUNT(CASE WHEN in_deezer_charts IS NULL THEN 1 END) AS in_deezer_charts,
  COUNT(CASE WHEN in_shazam_charts IS NULL THEN 1 END) AS in_shazam_charts  
FROM `hip-caster-419814.conj_dados_proj2.track_in_competition`

----------------------------------------- 
-- Essa fórmula busca apenas todas as colunas da tabela "track_in_competition", 
-- mas sem os valores nulos na coluna "in_shazam_charts", 
-- ou seja, dos 953 registros, ela busca apenas 903 registros.
SELECT
*
FROM
 `hip-caster-419814.conj_dados_proj2.track_in_competition`
WHERE  in_shazam_charts IS NOT NULL


--------------------------------------
-- Essa fórmula obtém toda a tabela "track_in_competition" com seus registros
-- e os valores nulos na coluna "in_shazam_charts" são preenchidos com o número 0.
SELECT
track_id,
in_apple_playlists,
in_apple_charts,
in_deezer_playlists,
in_deezer_charts,
IFNULL(in_shazam_charts, 0) AS in_shazam_charts_not_null,
FROM `hip-caster-419814.conj_dados_proj2.track_in_competition`


-----------------------------------------------------------------------------
-- Essa fórmula obtém toda a tabela "track_in_competition" com seus registros
-- e os valores nulos na coluna "in_shazam_charts" são preenchidos com a Medida de tendência central: mediana= 2.
-- Alteramos o valor track_id de 0:00 para 1001427, pois achamos mais conveniente do que deixar apenas três zeros como identificador. 
-- Conseguimos alterar para um valor de identificador de 7 dígitos.

/* WITH mediana_cte AS (
  SELECT
    APPROX_QUANTILES(in_shazam_charts, 2)[OFFSET(1)] AS mediana
  FROM
    `hip-caster-419814.conj_dados_proj2.track_in_competition`
)
SELECT
    CASE
      WHEN track_id = '0:00' THEN '1001427'
      ELSE track_id
    END AS track_id_atualizado,
    
     in_apple_playlists,in_apple_charts, in_deezer_playlists, in_deezer_charts,
  IFNULL(t.in_shazam_charts, m.mediana) AS in_shazam_charts_not_null
  
FROM
    `hip-caster-419814.conj_dados_proj2.track_in_competition` t, mediana_cte m
    ORDER BY track_id;

*/

---- Fórmula que traz todas as colunas, exceto "in_shazam_charts".
SELECT 
  CASE
      WHEN track_id = '0:00' THEN '1001427'
      ELSE track_id
  END AS track_id_atualizado,
  in_apple_playlists,in_apple_charts, in_deezer_playlists, in_deezer_charts,
  --EXCEPT(in_shazam_charts)
  
  
FROM `hip-caster-419814.conj_dados_proj2.track_in_competition` 


-- Uniao tabelas track_in_spotify e track_in_competition
SELECT
  sp.track_id_atualizado,
  sp.track_name_clean,
  sp.artist_s__name_clean,
  sp.artist_count,
  sp.released_year,
  sp.released_month,
  sp.released_day,
  sp.data_de_lancamento,
  sp.streams,
  sp.in_spotify_charts,
  sp.in_spotify_playlists, tc.in_apple_charts, tc.in_apple_playlists, tc.in_deezer_charts, tc.in_deezer_playlists,
  COALESCE(sp.in_spotify_playlists, 0) + COALESCE(tc.in_apple_playlists, 0) + COALESCE(tc.in_deezer_playlists, 0) AS total_participation_in_playlist
FROM
  `hip-caster-419814.conj_dados_proj2.track_in_spotify_original_v1` sp
INNER JOIN
  `hip-caster-419814.conj_dados_proj2.track_in_competition_original` tc
USING
  (track_id_atualizado);

  -- Uniao as 3 tabelas 
SELECT *  
FROM
  `hip-caster-419814.conj_dados_proj2.uniao_track_spotify_competition`
INNER JOIN
  `hip-caster-419814.conj_dados_proj2.track_technical_info_original`
USING
  (track_id_atualizado)

  /* 
  Se agregó a variable número total de músicas de artistas.
*/
WITH total_de_musicas_por_artista AS (
  SELECT
  artist_s__name_clean,
  COUNT(*) as count_songs

  FROM `hip-caster-419814.conj_dados_proj2.uniao_track_spotify_competition_tech_info`
  GROUP BY artist_s__name_clean
)


SELECT 
uniao.track_id_atualizado,
uniao.track_name_clean,
uniao.artist_s__name_clean,
total_de_musicas_por_artista.count_songs,
uniao.artist_count,
uniao.released_year,
uniao.released_month,
uniao.released_day,
uniao.data_de_lancamento,
uniao.streams,
uniao.in_spotify_charts,
uniao.in_spotify_playlists,
uniao.in_apple_charts,
uniao.in_apple_playlists,
uniao.in_deezer_charts,
uniao.in_deezer_playlists,
uniao.total_participation_in_playlist,
uniao.bpm,
uniao.danceability__,
uniao.valence__,
uniao.energy__,
uniao.acousticness__,
uniao.instrumentalness__,
uniao.liveness__,
uniao.speechiness__

FROM `hip-caster-419814.conj_dados_proj2.uniao_track_spotify_competition_tech_info` uniao
LEFT JOIN total_de_musicas_por_artista
#ON uniao.artist_s__name_clean = total_de_musicas_por_artista.artist_s__name_clean
USING
  (artist_s__name_clean)

-- Medidas de posicao 
WITH Terciles AS (
  SELECT
    track_id_atualizado,
    NTILE(3) OVER (ORDER BY streams) AS terciles_streams, 
    NTILE(3) OVER (ORDER BY bpm) AS terciles_bpm,
    NTILE(3) OVER (ORDER BY danceability__) AS terciles_danceability__,
    NTILE(3) OVER (ORDER BY valence__) AS terciles_valence__,
    NTILE(3) OVER (ORDER BY energy__) AS terciles_energy__,
    NTILE(3) OVER (ORDER BY acousticness__) AS terciles_acousticness__,
    NTILE(3) OVER (ORDER BY instrumentalness__) AS terciles_instrumentalness__,
    NTILE(3) OVER (ORDER BY liveness__) AS terciles_liveness__,
    NTILE(3) OVER (ORDER BY speechiness__) AS terciles_speechiness__,

  FROM
  `hip-caster-419814.conj_dados_proj2.dataset_v1`

)

SELECT 
a.*,
Terciles.terciles_streams,
IF(Terciles.terciles_streams = 1, "baixo", IF(Terciles.terciles_streams = 2, "baixo", "alto")) AS categoria_streams,
Terciles.terciles_bpm,
IF(Terciles.terciles_bpm = 1, "baixo", IF(Terciles.terciles_bpm = 2, "baixo", "alto")) AS categoria_bpm,
Terciles.terciles_danceability__,
IF(Terciles.terciles_danceability__ = 1, "baixo", IF(Terciles.terciles_danceability__ = 2, "baixo", "alto")) AS categoria_danceability,
Terciles.terciles_valence__,
IF(Terciles.terciles_valence__ = 1, "baixo", IF(Terciles.terciles_valence__ = 2, "baixo", "alto")) AS categoria_valence,
Terciles.terciles_energy__,
IF(Terciles.terciles_energy__ = 1, "baixo", IF(Terciles.terciles_energy__ = 2, "baixo", "alto")) AS categoria_energy,
Terciles.terciles_acousticness__,
IF(Terciles.terciles_acousticness__ = 1, "baixo", IF(Terciles.terciles_acousticness__ = 2, "baixo", "alto")) AS categoria_acousticness,
Terciles.terciles_instrumentalness__,
IF(Terciles.terciles_instrumentalness__ = 1, "baixo", IF(Terciles.terciles_instrumentalness__ = 2, "baixo", "alto")) AS categoria_instrumentalness,
Terciles.terciles_liveness__,
IF(Terciles.terciles_liveness__ = 1, "baixo", IF(Terciles.terciles_liveness__ = 2, "baixo", "alto")) AS categoria_liveness,
Terciles.terciles_speechiness__,
IF(Terciles.terciles_speechiness__ = 1, "baixo", IF(Terciles.terciles_speechiness__ = 2, "baixo", "alto")) AS categoria_speechiness
 FROM `hip-caster-419814.conj_dados_proj2.dataset_v1` a

LEFT JOIN Terciles
ON a.track_id_atualizado = Terciles.track_id_atualizado

