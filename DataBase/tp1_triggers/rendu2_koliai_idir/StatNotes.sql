drop view if exists StatNotes;

CREATE VIEW StatNotes AS(
    SELECT
        codeCours,
        intitule,
        min(note) AS min,
        max(note) AS max,
        avg(note) AS avg
    FROM
        suit NATURAL
        LEFT JOIN cours
    GROUP BY
        codeCours,
        intitule
);