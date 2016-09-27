package com.tellhow.companymgr.dao.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import com.siqiansoft.framework.bo.DatabaseBo;
import com.siqiansoft.framework.model.LoginModel;
import com.tellhow.companymgr.dao.CompanyMgrDao;
/**
 * 企业需求管理实现类
 * @author zhangsp
 *
 */
public class CompanyMgrDaoImpl implements CompanyMgrDao {

	DatabaseBo dbo = new DatabaseBo();
	Calendar c = Calendar.getInstance();
    SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat f2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String date = f.format(c.getTime());
    String time = f2.format(c.getTime());
	@Override
	/**
	 * 获取需求响应列表（对应平台中的记录集合）
	 * @param loginModel
	 * @return 平台的记录集合（需求响应管理下）
	 */
	public List<HashMap<String, String>> getDemandAnswerList(LoginModel loginModel) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> list2 = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> list3 = new ArrayList<HashMap<String, String>>();
		// 得到企业的具体信息
		HashMap<String, String> comMsg = this.getCompanyMsg(loginModel);
		String comId = comMsg.get("ID")==null?"":comMsg.get("ID");//企业id
		System.out.println("========================================comId="+comId);
		String sql = "select id did,demandmsg,demandtype2 from cs_demandmsg where cid = ?";
		try {
			list = dbo.prepareQuery(sql, new String[]{comId});
			if (list.size()>0) {
				for (int i = 0; i < list.size(); i++) {
					HashMap<String, String> map = new HashMap<String,String>();
					String status = "0";
					map.put("demandname", list.get(i).get("DEMANDMSG"));//需求名称
					map.put("demandtype", list.get(i).get("DEMANDTYPE2"));//需求二级分类
					map.put("demandid", list.get(i).get("DID"));//需求id
					// 根据需求id 查出响应个数
//					String sql2 = "select count(id) from cs_demand where did = ?";
//					list2 = dbo.prepareQuery(sql2, new String[]{list.get(i).get("DID")});
//					if (list2.size()>0) {
//						map.put("answercount", list2.get(0).get("COUNT"));
//					} else {
//						map.put("answercount", "");
//					}
					String sql2 = "select status from cs_demand where did = ?";
					list2 = dbo.prepareQuery(sql2, new String[]{list.get(i).get("DID")});
					for (int j = 0; j < list2.size(); j++) {
						// 对接状态取值，0为对接，1对接成功，2对接失败
						// 在所有记录中都是未对接 则为0；若有为对接和对接失败 则为2；若有成功的记录 则为1
						if ("2".equals(list2.get(j).get("STATUS"))) {
							status = "2";
						}
						if ("1".equals(list2.get(j).get("STATUS"))) {
							status = "1";
						}
						
					}
					map.put("status", status);//对接状态
					map.put("answercount", list2.size()+"");//响应数目
					list3.add(map);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list3;
	}

	@Override
	/**
	 * 保存需求信息（demand和demandmsg）
	 * @param loginModel
	 * @param map
	 */
	public void insertDemand(LoginModel loginModel, HashMap<String, String> map) {
		// TODO Auto-generated method stub
		// 获得企业信息
		HashMap<String, String> companyMsg = this.getCompanyMsg(loginModel);
		String comId = companyMsg.get("ID")==null?"":companyMsg.get("ID");//企业id
//		String demandMsg = map.get("demandmsg");//需求名称
//		String pubTime = map.get("pubtime");//发布时间
//		String contacts = map.get("contacts");//联系人
//		String contactTel = map.get("contacttel");//联系人电话
//		String price = map.get("price");//预算价格
//		String endDate = map.get("enddate");//预期结束时间
//		String demandType = map.get("demandtype");//需求一级类型
//		String demandType2 = map.get("demandtype2");//需求二级类型
//		String introduce = map.get("introduce");//介绍
//		String createTime = map.get("createtime");//创建时间
//		String checkStatus = map.get("checkstatus");//审核状态
		
		map.remove("cid");
		map.put("cid", comId);
		try {
			String demandId = dbo.insert(map, "CS_DEMANDMSG");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	// 根据loginmodel 获得 企业信息
	public HashMap<String, String> getCompanyMsg(LoginModel loginModel){
		List<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> companyMsg = new HashMap<String, String>();
		String usercode = loginModel.getUserCode();
		String sql = "select * from cs_company where usercode = ?";
		try {
			list = dbo.prepareQuery(sql, new String[]{usercode});
			if (list.size()>0) {
				companyMsg = list.get(0);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return companyMsg;
	}

	@Override
	/**
	 * 得到企业已审核需求列表
	 * @param loginModel
	 */
	public List<HashMap<String, String>> getCheckedDemandCom(LoginModel loginModel) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> list2 = new ArrayList<HashMap<String, String>>();
		// 得到企业的具体信息
		HashMap<String, String> comMsg = this.getCompanyMsg(loginModel);
		String comId = comMsg.get("ID")==null?"":comMsg.get("ID");//企业id
		System.out.println("========================================comId="+comId);
		String sql = "select * from cs_demandmsg where cid = ? and checkstatus!=0";
		try {
			list = dbo.prepareQuery(sql, new String[]{comId});
			if (list.size()>0) {
				for (int i = 0; i < list.size(); i++) {
					HashMap<String, String> map = new HashMap<String,String>();
					map.put("demandmsg", list.get(i).get("DEMANDMSG"));//需求名称
					map.put("demandtype2", list.get(i).get("DEMANDTYPE2"));//需求二级分类
					map.put("id", list.get(i).get("DID"));//需求id
					map.put("pubtime", list.get(i).get("PUBTIME"));//发布时间
					map.put("cid", list.get(i).get("CID"));//企业id
					map.put("contacts", list.get(i).get("CONTACTS"));//联系人
					map.put("contacttel", list.get(i).get("CONTACTTEL"));//联系电话
					map.put("price", list.get(i).get("PRICE"));//预算价格
					map.put("enddate", list.get(i).get("ENDDATE"));//期望完成时间
					map.put("demandtype", list.get(i).get("DEMANGTYPE"));//需求一级类别
					map.put("introduce", list.get(i).get("INTRODUCE"));//介绍
					map.put("createtime", list.get(i).get("CREATETIME"));//创建时间
					map.put("checkstatus", list.get(i).get("CHECKSTATUS"));//审核状态
					list2.add(map);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list2;
	}

	@Override
	/**
	 * 获得响应的服务机构列表（需求响应管理下）
	 * @param id 需求信息的id
	 */
	public List<HashMap<String, String>> getAnsweredService(String demandid) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> list2 = new ArrayList<HashMap<String, String>>();
		// 需求关系和服务机构连表查询，sid相等，服务机构删除状态不为1
		System.out.println("===============================demandid="+demandid);
		String sql = "select d.id,d.status,d.evaluatestatus,s.businessname,s.contacts,s.fixedphones from cs_demand d ,cs_servicesorganization s where d.did = ? and d.sid = s.id and s.isdel !=1";
		try {
			list = dbo.prepareQuery(sql, new String[]{demandid});
			if (list.size()>0) {
				for (int i = 0; i < list.size(); i++) { 
					HashMap<String, String> map = new HashMap<String,String>();
					map.put("servicename", list.get(i).get("BUSINESSNAME"));//服务机构名称
					map.put("dockstatus", list.get(i).get("STATUS"));//对接状态
					map.put("id", list.get(i).get("ID"));//需求关系id
					map.put("evaluatestatus", list.get(i).get("EVALUATESTATUS"));//评价状态
					map.put("contacts", list.get(i).get("CONTACTS"));//联系人
					map.put("contacttel", list.get(i).get("FIXEDPHONES"));//联系电话
					list2.add(map);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list2;
	}

	@Override
	/**
	 * 获得申请的服务列表（企业服务申请下）
	 * @param loginModel
	 */
	public List<HashMap<String, String>> getAppliedService(LoginModel loginModel) {
		// TODO Auto-generated method stub
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> list2 = new ArrayList<HashMap<String, String>>();
		String cid = "";
		HashMap<String, String> comMap = this.getCompanyMsg(loginModel);
		cid = comMap.get("ID")==null?"":comMap.get("ID");
		// 企业所申请的所有服务
		System.out.println("===============================cid="+cid);
		String sql = "select a.*,b.businessname,b.contacts,b.fixedphones from(select s.id,s.status,s.evaluatestatus,m.servicename,m.oganizationcode from cs_server s,cs_servicesmsg m where s.cid = ? and s.sid=m.id)a,cs_servicesorganization b where b.businesscode=a.oganizationcode";
		try {
			list = dbo.prepareQuery(sql, new String[]{cid});
			if (list.size()>0) {
				int i = 0;
					HashMap<String, String> map = new HashMap<String,String>();
					map.put("id", list.get(i).get("ID"));//服务关系id
					map.put("servername", list.get(i).get("BUSINESSNAME"));//服务机构名称
					map.put("servicename", list.get(i).get("SERVICENAME"));//服务名称
					map.put("dockstatus", list.get(i).get("STATUS"));//对接状态
					map.put("evaluatestatus", list.get(i).get("EVALUATESTATUS"));//评价状态
					map.put("contacts", list.get(i).get("CONTACTS"));//联系人
					map.put("contacttel", list.get(i).get("FIXEDPHONES"));//联系电话
					list2.add(map);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list2;
	}

	@Override
	/**
	 * 保存企业对服务机构提供服务的评价（企业服务申请下）
	 * 存在cs_server里,企业对服务机构所提供服务的评价（企业服务申请管理模块下）
	 * @param loginModel
	 * @param map 表单数据
	 */
	public void saveEvaluateByCom(LoginModel loginModel, HashMap<String, String> map) {
		// TODO Auto-generated method stub
		String serviceId = map.get("serviceid");// 服务关系id（cs_server表）
		String scoreString = map.get("score"); 
		int score = 3; // 评价分数
		// 如果评价在1~5之间(如果数据有问题，评分取中位数3)
		if (!(Integer.parseInt(scoreString)>5 || Integer.parseInt(scoreString)<1)) {
			score = Integer.parseInt(scoreString);
		}
		String evaluate = map.get("evaluate");
		String sql = "update cs_server set EVALUATESTATUS = 1 , EVALUATE = ?,EVALUATELEVEL=? where ID=? ";
		try {
			dbo.prepareUpdate(sql, new String[]{evaluate,score+"",serviceId });
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 保存企业的评价，企业发布的需求，有服务机构响应，对接成功后的评价
	 * 存在cs_demand里,在需求响应管理下
	 * @param loginModel
	 * @param map 表单数据
	 */
	public void saveEvaluateForDemand(LoginModel loginModel,HashMap<String, String> map){
		String demandId = map.get("demandid1");// 需求关系id（cs_demand表）
		String scoreString = map.get("score");
		int score = 3; // 评价分数
		// 如果评价在1~5之间(如果数据有问题，评分取中位数3)
		if (!(Integer.parseInt(scoreString)>5 || Integer.parseInt(scoreString)<1)) {
			score = Integer.parseInt(scoreString);
		}
		String evaluate = map.get("evaluate");
		String sql = "update cs_demand set EVALUATESTATUS = 1 , EVALUATE = ?,EVALUATELEVEL=? where ID=? ";
		try {
			dbo.prepareUpdate(sql, new String[]{evaluate,score+"",demandId });
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * 合作。企业发布需求后，服务机构去响应服务的合作
	 * @param id 需求关系表的id
	 * @return
	 */
	public HashMap<String, String> work(String id){
		String sql = "update cs_demand set status = 1 where id = ?";
		// String did = "";//demandId 需求id（cs_demandmsg）
		try {
			dbo.prepareUpdate(sql, new String[]{id});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 不合作  企业发布需求后，服务机构去响应服务的不合作
	 * @param id 需求关系表的id
	 * @return
	 */
	public List<HashMap<String, String>> notWork(String id){
		String sql = "update cs_demand set status = 2 where id = ?";
		try {
			dbo.prepareUpdate(sql, new String[]{id});
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}














