package net.property.index;


import java.io.IOException;
import java.util.Set;

import net.property.data.SearchDataManager;


import org.apache.solr.client.solrj.SolrClient;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.common.SolrInputDocument;

public class Indexer implements Runnable {
	public void run() {	
		try {
			Set<SolrInputDocument> properties = SearchDataManager.getInstance().getPropertyToIndex();
			while (properties.size() > 0) {
				SolrClient server = SolrServerHolder.getConcurrentSolrServer();
				server.add(properties,120000);
				//server.commit();
				properties = SearchDataManager.getInstance().getPropertyToIndex();
			}
		} catch (SolrServerException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
