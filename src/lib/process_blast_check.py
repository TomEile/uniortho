import sys
import pandas as pd


BLAST_OUTFMT_6 = ["qseqid", "sseqid", "pident", "length", 
                  "mismatch", "gapopen", "qstart", "qend", 
                  "sstart", "send", "evalue", "bitscore"]

blastfile = sys.argv[1]
genesfile = sys.argv[2]
outdir = sys.argv[3]

df = pd.read_table(blastfile, names=BLAST_OUTFMT_6)
genes = pd.read_table(genesfile, delim_whitespace=True)

df_summ = df.groupby("qseqid").agg(
    dict(
        sseqid = ['nunique']
    )
)

uq_hits = df_summ[df_summ["sseqid"]["nunique"] == 1].index
df_uq = df[df["qseqid"].isin(uq_hits)]
# can still be multiple internal hits
df_uq_n = df_uq.groupby("qseqid").agg({"sseqid": "count"})
df_uq_n = df_uq_n[df_uq_n["sseqid"] == 1]

genes[genes["gene"].isin(df_uq_n.index)]\
    .to_csv(f"{outdir}/uniquegenes_checked.tsv", sep="\t", index=False)
