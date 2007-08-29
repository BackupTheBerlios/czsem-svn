/**
 * 
 */
package cz.cuni.mff.dedek.wordnet;

import java.util.LinkedHashSet;
import java.util.Set;

import javax.xml.xpath.*;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * @author dedej1am
 *
 */
public class SubtreeXMLIntersection
{
	public static void findIntersection(Node node1, Node node2) throws XPathExpressionException
	{
		XPathFactory factory = XPathFactory.newInstance();
		XPath xpath = factory.newXPath();
		
		XPathExpression id_expr = xpath.compile("//TreeNode/@id");
		
		Object result1 = id_expr.evaluate(node1, XPathConstants.NODESET);
		Object result2 = id_expr.evaluate(node2, XPathConstants.NODESET);
		
		Set<String> id_set1 = new LinkedHashSet<String>();
		Set<String> id_set2 = new LinkedHashSet<String>();

		NodeList nodes1 = (NodeList) result1;
		NodeList nodes2 = (NodeList) result2;
		
		for (int i = 0; i < nodes1.getLength(); i++)
		{
			id_set1.add(nodes1.item(i).getNodeValue());
		}
		for (int i = 0; i < nodes2.getLength(); i++)
		{
			id_set2.add(nodes2.item(i).getNodeValue());
		}
		
		System.out.println("----- intersection: ----- "); 						

		
		//intersection:
		id_set1.retainAll(id_set2);

		for (String s : id_set1)
		{
			XPathExpression value_expr = xpath.compile("//TreeNode[@id='"+ s +"']/@value");
			Object result = value_expr.evaluate(node1, XPathConstants.NODESET);
			NodeList nodes = (NodeList) result;			

			System.out.println(s + " - " + nodes.item(0).getNodeValue()); 						
		}
		
	}
}
