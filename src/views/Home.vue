<template>

  <div class="home" style="">
    <!--顶部导航栏-->
    <Topnav></Topnav>

    <!--搜索框-->
    <el-row :gutter="10" style="height: 90px;">
      <el-col :span="6">
        <div style="padding-left: 45px;"><img src="../assets/image/logonew.png" alt=""></div>
      </el-col>
      <el-col :span="12">
        <div style="margin-top: 15px">
          <el-input
              placeholder="请输入搜索内容"
              v-model="inputSearch"
              class="input-with-select"
              clearable
          >
            <template #append>
              <el-button icon="el-icon-search"></el-button>
            </template>
          </el-input>
        </div>
      </el-col>
    </el-row>

    <div class="common-layout">
      <el-container style="height: 1000px; border: 1px solid #eee;">
        <!--侧边导航栏 -->
        <el-aside width="250px" style="text-align: left" class="affix-container">
          <keep-alive>
            <SideMenu @categoryChange="categoryChange(($event))"></SideMenu>
          </keep-alive>

        </el-aside>

        <!--商品展示主窗口 -->
        <el-container style="background-color: #F5F5F5;" >
          <el-header style="height : 38px">
            <el-tabs v-model="activeName" @tab-click="handleClick">
              <el-tab-pane label="交易区" name="first">
                <el-main>
                   <goods :categoryId="categoryId" :inputSearch="inputSearch"></goods>
                </el-main>
              </el-tab-pane>
              <el-tab-pane label="志愿区" name="second">
                 <el-main>
                   <charity></charity>
                 </el-main>
              </el-tab-pane>
            </el-tabs>
          </el-header>
        </el-container>

      </el-container>

    </div>

  </div>
</template>

<script>
import Logdialog from "../components/common/logandre/Logdialog";
import Topnav from "../components/content/topnavbar/Topnav"
import Goods from "./mainview/Goods";
import SideMenu from "../components/content/goods/SideMenu";
import Charity from "./mainview/Charity";

export default {
  name: 'Home',
  components: {
    Charity,
    SideMenu,
    Goods,
    Logdialog,
    Topnav
  },
  data() {
    return {
      activeName: 'first',
      categoryId:'',
      inputSearch:''
    }
  },
  methods: {
    handleClick(tab, event) {
    },
    categoryChange(selectValue){
       this.categoryId = selectValue
      console.log("index:"+this.categoryId)
    }
  }


}
</script>

<style scoped>
.el-link--inner {
  font-size: 14px;
  line-height: 30px;
  padding-bottom: 4px;
}
.el-header {
  background-color: #F5F5F5;
  color: #333;
  text-align: center;
}

.el-aside {
  background-color: #545c64;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  background-color: #fff;
  color: #333;
}

</style>
