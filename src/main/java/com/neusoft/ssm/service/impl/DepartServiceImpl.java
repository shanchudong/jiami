package com.neusoft.ssm.service.impl;

import com.neusoft.ssm.bean.Department;
import com.neusoft.ssm.bean.DepartmentExample;
import com.neusoft.ssm.dao.DepartmentMapper;
import com.neusoft.ssm.exception.FileTypeException;
import com.neusoft.ssm.exception.GettingTypeException;
import com.neusoft.ssm.service.DepartmentService;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;

@Service
public class DepartServiceImpl implements DepartmentService {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public int uploadUserXls(MultipartFile file) throws IOException {
        if(!validateType(file))	return -1;
        List<Department> departmentList = new ArrayList<Department>();
        Department department = null;
        Workbook book = null;
        try{
            book = new XSSFWorkbook(file.getInputStream());
        }catch(Exception e){
            book = new HSSFWorkbook(file.getInputStream());
        }
        Sheet sheet = book.getSheetAt(0);
        //for debug: show the name of sheet that we get
//		logger.debug("sheet name = " + book.getSheetAt(0));
        for(int i = sheet.getFirstRowNum()+1; i <= sheet.getLastRowNum(); i++){
            department = new Department();
            departmentList.add(department);
            Row row = sheet.getRow(i);
            department.setId((int)row.getCell(0).getNumericCellValue());
            department.setDeptcode((String) row.getCell(1).getStringCellValue());
            department.setDeptname((String)row.getCell(2).getStringCellValue());
            XSSFCell cell3= (XSSFCell) row.getCell(3);
            cell3.setCellType(CellType.STRING);
            department.setDeptcategoryid(cell3.getStringCellValue());
            XSSFCell cell4= (XSSFCell) row.getCell(4);
            cell4.setCellType(CellType.STRING);
            department.setDepttype(cell4.getStringCellValue());

//			Iterator<Cell> cells = row.cellIterator();
//			while(cells.hasNext()){
//				//TODO modify this function by append method "getCellValueType()
//				//now this function is so stupid.
//				Cell cell = cells.next();
//				if(i>0){
//					logger.debug(String.valueOf(cell.getNumericCellValue()));
//				}else{
//					logger.debug(cell.getStringCellValue());
//				}
//			}
        }
        if(!departmentList.isEmpty()){
            return departmentMapper.uploadDepartmentInfo(departmentList);
        }
//		logger.debug("last row = " + sheet.getLastRowNum());
        return 0;
    }

    private boolean validateType(MultipartFile file){
        String fileType;
        try{
            //get MultipartFile original filename to validate file type.
            String fileName = file.getOriginalFilename();
            fileType = fileName.substring(fileName.lastIndexOf('.'),
                    fileName.lastIndexOf('s') + 1);
            if(fileType.isEmpty() || !fileType.toLowerCase().equals(".xls")){
                throw new FileTypeException("the file introduced is not .xls file.");
            }
        }catch(GettingTypeException e){
            logger.error("error occurs while getting file type.");
            return false;
        }catch(FileTypeException e){
            logger.error("the file introduced is not .xls file.");
            return false;
        }
        return true;
    }

    @Override
    public Map<String,String> findDistinctID() {
        Map<String,Map<String,String>> objectMap= departmentMapper.selectDistinctID();
//        Map<String,Map<String,String>> objectMap= departmentDao.selectDistinctID();


        Map<String, String> rmap = new HashMap<>();

//        rmap.put("name", "111");
//        rmap.put("name", "222");
        for (Map.Entry<String,Map<String,String>> entry:objectMap.entrySet()) {
            rmap.put(entry.getValue().get("Id"),entry.getValue().get("ConstantName") );
        }
        List<Map.Entry<String,String>> list = new ArrayList<>(rmap.entrySet());
        Collections.sort(list,new Comparator<Map.Entry<String,String>>() {
            //升序排序
            @Override
            public int compare(Map.Entry<String, String> o1,
                               Map.Entry<String, String> o2) {
                if (Integer.valueOf(o1.getKey()) >= Integer.valueOf(o2.getKey())) {
                    return 1;
                } else {
                    return -1;
                }
            }

        });
        rmap=new HashMap<>();
        for (Map.Entry<String,String> entry:list) {
            rmap.put(entry.getKey(), entry.getValue());
        }
//        Map<String, String> sortMap =
        System.out.println();
        return rmap;
    }

    @Override
    public List<Department> findByDeptcgID(String id) {
        return departmentMapper.selectByDeptcgID(id);
    }

    @Override
//    @CachePut(value = "department")
    public List<Department> findAll() {
        return departmentMapper.findAll();
    }

    @Override
    public Department findById(Integer id) {
        return departmentMapper.selectByPrimaryKey(id);
    }

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return departmentMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insertSelective(Department record) {
        return departmentMapper.insertSelective(record);
    }

    @Override
    public int updateByPrimaryKeySelective(Department record) {
        return departmentMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Department> getSearchDept(String keyword,String CgID) {
        return departmentMapper.searchDept(keyword,CgID);
    }

    @Override
    public String getNameById(Integer id) {
        return departmentMapper.getNameById(id);
    }

    @Override
    @Transactional
    public String findNameById(Long id) {
        return departmentMapper.findNameById(id);
    }

}
