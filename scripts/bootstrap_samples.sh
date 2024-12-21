#!/usr/bin/env bash

input_data="$1"
output_data="$2"

if [ ! -d "${input_data}" ]; then
    1>&2 echo "error: missing input data directory \"${input_data}\""
    exit 1
fi

if [ ! -d "${output_data}" ]; then
    1>&2 echo "error: missing output data directory \"${output_data}\""
    exit 1
fi

cd "${input_data}" || exit 1

# https://jbrowse.org/jb2/docs/quickstart_web/#adding-a-genome-assembly-in-fasta-format
# shellcheck disable=SC2044
for fn in $(find . -type f -name "*.fasta" -o -name "*.fa" -o -name "*.faa" -o -name "*.fna"); do
    # Remove file extension and cleanup dots
    target=$(echo "${fn%\.*}" | sed 's#[^\.][\.]#_#g' | tr -s '_')

    samtools faidx "${fn}"
    jbrowse add-assembly "${fn}" --load copy --out "${output_data}/${target}"
done

# https://jbrowse.org/jb2/docs/quickstart_web/#adding-a-gff3-file-with-gff3tabix
# shellcheck disable=SC2044
for fn in $(find . -type f -name "*.gff"); do
    # Remove file extension and cleanup dots
    target=$(echo "${fn%\.*}" | sed 's#[^\.][\.]#_#g' | tr -s '_')

    jbrowse sort-gff "${fn}" | bgzip > "${fn}.gz"
    tabix "${fn}.gz"
    jbrowse add-track "${fn}.gz" --load copy --out "${output_data}/${target}"
done
