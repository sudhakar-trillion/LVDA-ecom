<?php
class ModelCatalogCategory extends Model {
	public function getCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");

		return $query->row;
	}

	public function getCategories($parent_id = 0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

		return $query->rows;
	}

	public function getCategoryFilters($category_id) {
		$implode = array();

		$query = $this->db->query("SELECT filter_id FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$implode[] = (int)$result['filter_id'];
		}

		$filter_group_data = array();

		if ($implode) {
			$filter_group_query = $this->db->query("SELECT DISTINCT f.filter_group_id, fgd.name, fg.sort_order FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_group fg ON (f.filter_group_id = fg.filter_group_id) LEFT JOIN " . DB_PREFIX . "filter_group_description fgd ON (fg.filter_group_id = fgd.filter_group_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND fgd.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY f.filter_group_id ORDER BY fg.sort_order, LCASE(fgd.name)");

			foreach ($filter_group_query->rows as $filter_group) {
				$filter_data = array();

				$filter_query = $this->db->query("SELECT DISTINCT f.filter_id, fd.name FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_description fd ON (f.filter_id = fd.filter_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND f.filter_group_id = '" . (int)$filter_group['filter_group_id'] . "' AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY f.sort_order, LCASE(fd.name)");

				foreach ($filter_query->rows as $filter) {
					$filter_data[] = array(
						'filter_id' => $filter['filter_id'],
						'name'      => $filter['name']
					);
				}

				if ($filter_data) {
					$filter_group_data[] = array(
						'filter_group_id' => $filter_group['filter_group_id'],
						'name'            => $filter_group['name'],
						'filter'          => $filter_data
					);
				}
			}
		}

		return $filter_group_data;
	}

	public function getCategoryLayoutId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;
		}
	}

	public function getTotalCategoriesByCategoryId($parent_id = 0) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");

		return $query->row['total'];
	}
	
	
	public function getCategorySaleProducts($categoryId)
	{
		$query = $this->db->query('SELECT prd.image, alias.keyword as seourl  FROM oc_product_special as spl join oc_product_to_category as prdcat on prdcat.product_id=spl.product_id join oc_product_image as prd on prd.product_id=spl.product_id join oc_url_alias as alias on alias.query=concat("product_id=","",spl.product_id) where prdcat.category_id='.$categoryId);
		
		if($query->num_rows>0)
		{
			$salesProducts=array();
			foreach($query->rows as $inv=>$data)
			{
				$salesProducts[] = array(
											"image"=>$data['image'],
											"seourl"=>$data['seourl']
										);
			}
			return 	$salesProducts;
		}
		else
		return "0";
		
		
		
	}
	
	public function getSearch($data) {
		
		//$query = $this->db->query("SELECT color FROM " . DB_PREFIX . "category_description where category_id = '".$category_id."' and color = '1'");
		$query = $this->db->query("SELECT keyword FROM " . DB_PREFIX . "url_alias where keyword like '%".$data['term']."%' and query like 'product_id=%'");

		return $query->rows;
		
	}
	
	public function getCategoryName($prdid)
	{
		$qry = $this->db->query("SELECT parent_id,cat.category_id as subcat from oc_category as cat join oc_product_to_category prdtocat on prdtocat.category_id=cat.category_id where prdtocat.product_id=".$prdid." Limit 1");	
		
	/*
		if( $qry->num_rows ==1)
		{
			
			foreach( $qry->rows as $val)
			{
				$Parentid = $val['parent_id'];
				
				$query = $this->db->query("SELECT  name FROM oc_category_description where category_id=".$Parentid);
				$categ = '';
				
				foreach($query->row as $catname)
				{
					$categ =  str_replace(" ","-",strtolower($catname));
					$categ=$categ.'-';
				}
				#echo $categ; exit; 
				$query = $this->db->query("SELECT  name FROM oc_category_description where category_id=".$val['subcat']);
				
				foreach($query->row as $catname)
				{
					$subcateg =  str_replace(" ","-",strtolower($catname));
					$subcateg = $categ.$subcateg;
				}
				
				return  $subcateg; 
			}
		}
		else
		{
				
		}
		*/
		
	if($qry->row['subcat']>0)
		{
			$qrey = $this->db->query("select meta_title from oc_category_description where category_id=".$qry->row['subcat']);	
			$Sel_Category =$qrey->row['meta_title'];
		}
		else
		{
			$qrey = $this->db->query("select meta_title from oc_category_description where category_id=".$category_id);	
			$Sel_Category =$qrey->row['meta_title'];
		}
		
		return $Sel_Category;
		
		
	}

	public function getProductCategory($category_id)
	{
		$qry = $this->db->query('select product_id from oc_product_to_category where category_id='.$category_id.' order by product_id DESC LIMIT 1');
		
		if( $qry->num_rows>0 )
		{
			$product_id = $qry->row['product_id'];
			$qrey = $this->db->query('select image from oc_product where product_id='.$product_id.' order by product_id DESC LIMIT 1');
			return $qrey->row['image'];
		}
		else
			return "0";
	}
	
	
}