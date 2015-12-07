package com.asvcloud.zone.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * Created by g.zw@asvcloud.com on 15/11/19.15:04
 * 昨夜西风凋碧树.独上高楼,望尽天涯路.
 * 衣带渐宽终不悔,为伊消得人憔悴.
 * 众里寻他千百度,蓦然回首,那人却在灯火阑珊处.
 */
public class Schoolmate extends DataEntity<Schoolmate> {

    @Length(max = 32)
    @ExcelField(title="名", align=2, sort=1)
    private String firstname;//名
    @Length(max = 32)
    @ExcelField(title="姓", align=2, sort=2)
    private String familyname;//姓
    @Length(max = 10)
    @ExcelField(title="中文名", align=2, sort=3)
    private String cnname;//中文名
    @NotNull
    @ExcelField(title="生日", align=2, sort=4)
    private Date birthday;//生日
    @Length(max = 10)
    private String nationality;//国籍
    @ExcelField(title="国籍", align=2, sort=5)
    private String nationalitycn;//国籍中文名

    @NotBlank
    private String gender;//性别

    @ExcelField(title="性别", align=2, sort=6)
    private String gendercn;//性别中文名

    @Length(max = 10)
    @ExcelField(title="职业", align=2, sort=7)
    private String occupations;//职业
    @Length(max = 100)
    @ExcelField(title="工作地址", align=2, sort=8)
    private String workingaddress;//工作地址
    @Length(max = 10)
    @ExcelField(title="邮编", align=2, sort=9)
    private String zipcode;//邮编
    @Length(max = 10)
    @ExcelField(title="学习类别", align=2, sort=10)
    private String learningtype;//学习类别
    @NotNull
    @ExcelField(title="入学时间", align=2, sort=11)
    private Date enrollment;//入学时间
    @NotNull
    @ExcelField(title="毕业时间", align=2, sort=12)
    private Date graduation;//毕业时间
    @Length(max = 100)
    @ExcelField(title="永久地址", align=2, sort=13)
    private String address;//永久地址
    @Length(max = 32)
    @ExcelField(title="电话", align=2, sort=14)
    private String tel;//电话
    @Length(max = 100)
    @ExcelField(title="邮件", align=2, sort=15)
    private String email;//邮件
    @Length(max = 32)
    @ExcelField(title="传真", align=2, sort=16)
    private String fax;//传真
    @Length(max = 10)
    @ExcelField(title="主修专业", align=2, sort=17)
    private String subject;//主修专业

    public String getLearningtype() {
        return learningtype;
    }

    public void setLearningtype(String learningtype) {
        this.learningtype = learningtype;
    }

    public Date getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(Date enrollment) {
        this.enrollment = enrollment;
    }

    public Date getGraduation() {
        return graduation;
    }

    public void setGraduation(Date graduation) {
        this.graduation = graduation;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public String getFamilyname() {
        return familyname;
    }

    public void setFamilyname(String familyname) {
        this.familyname = familyname;
    }

    public String getCnname() {
        return cnname;
    }

    public void setCnname(String cnname) {
        this.cnname = cnname;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getOccupations() {
        return occupations;
    }

    public void setOccupations(String occupations) {
        this.occupations = occupations;
    }

    public String getWorkingaddress() {
        return workingaddress;
    }

    public void setWorkingaddress(String workingaddress) {
        this.workingaddress = workingaddress;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getNationalitycn() {
        return nationalitycn;
    }

    public void setNationalitycn(String nationalitycn) {
        this.nationalitycn = nationalitycn;
    }

    public String getGendercn() {
        return gendercn;
    }

    public void setGendercn(String gendercn) {
        this.gendercn = gendercn;
    }
}
