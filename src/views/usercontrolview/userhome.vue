<template>
  <div>
    <el-container>
      <el-header height="35px">
        <topnav></topnav>
      </el-header>
      <el-container  style="height: 670px">
        <el-aside width="250px" style="text-align: left">
            <SideMenu></SideMenu>
        </el-aside>
        <el-main>
          <div>
            <el-breadcrumb separator-class="el-icon-arrow-right">
              <el-breadcrumb-item v-for="(item,index) in breadList"  :key="index">{{item.meta.title}}</el-breadcrumb-item>
            </el-breadcrumb>
          </div>
          <div style="margin-top: 15px;margin-left: 8px; background: #ffffff">
            <router-view/>
          </div>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
import Topnav from "../../components/content/topnavbar/Topnav";
import SideMenu from "../../components/content/userhome/SideMenu";

export default {
  name: "userhome",
  components:{
    SideMenu,
    Topnav
  },
  data(){
    return {
      breadList:[]
    }
  },
  watch:
      {
        $route() {
          this.getBreadcrumb();
        }
      },
  created() {
    this.getBreadcrumb();
  },
  methods:{
    getBreadcrumb(){
      this.breadList=this.$route.matched
    }
  }
}
</script>

<style>
.el-header{
  background-color: #fff;
  color: #333;
  text-align: center;
  line-height: 35px;
}

.el-aside {
  background-color: #545c64;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  background-color: #F5F5F5;
  color: #333;
  text-align: center;
}

body > .el-container {
  margin-bottom: 10px;
}

.el-container:nth-child(5) .el-aside,
.el-container:nth-child(6) .el-aside {
  line-height: 260px;
}

.el-container:nth-child(7) .el-aside {
  line-height: 320px;
}
</style>