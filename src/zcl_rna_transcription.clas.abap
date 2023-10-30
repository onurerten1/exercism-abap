CLASS zcl_rna_transcription DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS
      transcribe
        IMPORTING strand        TYPE string
        RETURNING VALUE(result) TYPE string.

  PRIVATE SECTION.
    CONSTANTS adenine  TYPE c LENGTH 1 VALUE 'A'.
    CONSTANTS cytosine TYPE c LENGTH 1 VALUE 'C'.
    CONSTANTS guanine  TYPE c LENGTH 1 VALUE 'G'.
    CONSTANTS thymine  TYPE c LENGTH 1 VALUE 'T'.
    CONSTANTS uracil   TYPE c LENGTH 1 VALUE 'U'.

    METHODS
      dna_to_rna_nucleotide
        IMPORTING nucleotide    TYPE string
        RETURNING VALUE(result) TYPE string.
ENDCLASS.


CLASS zcl_rna_transcription IMPLEMENTATION.
  METHOD transcribe.
    FINAL(sequence) = strand.
    DO strlen( sequence ) TIMES.
      FINAL(offset) = sy-index - 1.
      FINAL(nucleotide) = sequence+offset(1).
      result = |{ result }{ dna_to_rna_nucleotide( nucleotide ) }|.
    ENDDO.
    CONDENSE result.
  ENDMETHOD.

  METHOD dna_to_rna_nucleotide.
    result = SWITCH #( nucleotide
                       WHEN guanine  THEN cytosine
                       WHEN cytosine THEN guanine
                       WHEN thymine  THEN adenine
                       WHEN adenine  THEN uracil ).
  ENDMETHOD.
ENDCLASS.