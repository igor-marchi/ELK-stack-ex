import { Router } from "express";
import { Client } from "@elastic/elasticsearch";

const router = Router();
const client = new Client({ node: "http://localhost:9200" });

router.get("/customers", async (req, res) => {
  try {
    const { id, email, cpf_cnpj, name } = req.query;

    const query: any = {
      bool: {
        must: [],
      },
    };

    if (id) query.bool.must.push({ match: { id } });
    if (email) query.bool.must.push({ match: { email } });
    if (cpf_cnpj) query.bool.must.push({ match: { cpf_cnpj } });
    if (name) query.bool.must.push({ match: { name } });

    const result = await client.search({
      index: "customer",
      body: {
        query,
      },
    });

    res.json(
      result.hits.hits.map((hit: any) => ({
        id: hit._source?.id,
        email: hit._source?.email,
        cpf_cnpj: hit._source?.cpf_cnpj,
        name: hit._source?.name,
      }))
    );
  } catch (error) {
    console.error(error);
    res.status(500).send("Error querying Elasticsearch");
  }
});

export default router;
