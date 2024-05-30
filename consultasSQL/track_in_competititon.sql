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