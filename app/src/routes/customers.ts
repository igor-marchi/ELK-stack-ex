import { Router } from "express";
import { Client } from "@elastic/elasticsearch";
import { QueryDslQueryContainer } from "@elastic/elasticsearch/lib/api/types";

interface Document {
  id: string;
  email: string;
  cpf_cnpj: string;
  name: string;
  address: string;
}

const router = Router();
const client = new Client({ node: process.env.ELASTICSEARCH_NODE });

router.get("/customers", async (req, res) => {
  try {
    const { id, email, cpf_cnpj, name } = req.query;

    const mustQueries: QueryDslQueryContainer[] = [];

    if (id) mustQueries.push({ match: { id: id as string } });
    if (email) mustQueries.push({ match: { email: email as string } });
    if (cpf_cnpj) mustQueries.push({ match: { cpf_cnpj: cpf_cnpj as string } });
    if (name) mustQueries.push({ match: { name: name as string } });

    const query: QueryDslQueryContainer = {
      bool: {
        must: mustQueries,
      },
    };

    const result = await client.search<Document>({
      index: "customer",
      query,
    });

    res.json(
      result.hits.hits.map((hit) => ({
        id: hit._source?.id,
        email: hit._source?.email,
        cpf_cnpj: hit._source?.cpf_cnpj,
        name: hit._source?.name,
        address: hit._source?.address,
      }))
    );
  } catch (error) {
    console.error(error);
    res.status(500).send("Error querying Elasticsearch");
  }
});

export default router;
