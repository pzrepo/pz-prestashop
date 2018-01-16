<?php
require_once(dirname(__FILE__).'/../../config/config.inc.php');
$action = Tools::getValue('action');
$pzprestashop = Module::getInstanceByName('pzprestashop');
switch($action)
{
    case "get_states":
        $iso = Tools::getValue('id_country');
        $id_country = Country::getByIso($iso);
        $states = State::getStatesByIdCountry($id_country);
		if(!empty($states))
		{	
			$html = '<select name="TMPL_state" id="selectState" class="form-control"><option value="">-</option>';
			foreach($states as $key=>$value)
			{            
				$html .= "<option value='".$value['iso_code']."'>".$value['name']."</option>"; 
			}
			$html .='</select>';
		}else {
			$html = '<input class="form-control" id="textState" type="text" name="TMPL_state" placeholder="Enter state code.">';
		}
		echo $html;
        exit;
        break;
    case "get_terminal":
    	$currency_iso = Tools::getValue('currency_iso');
    	$card_type = Tools::getValue('card_type');    	
    	$sql = "SELECT `terminal_id`,`payment_type` FROM `"._DB_PREFIX_.$pzprestashop->name."` WHERE `currency`='".$currency_iso."' AND `card_type`='".$card_type."'";
    	$result = Db::getInstance()->getRow($sql);
    	echo json_encode($result);
    	exit;
    	break;
    case "collect_card_types":
    	$card_types = $pzprestashop->getCardTypes();
    	foreach($card_types as $key=>$value)
    	{
    		$card_types_array[$value['payment_type_id']][] = array("card_type_id"=>$value['card_type_id'],"card_type_name"=>$value["card_type_name"]);
    	}
    	
    	echo json_encode($card_types_array);
    	break;
    
}
?>