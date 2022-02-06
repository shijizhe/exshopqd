<template>
  <el-row :gutter="20" style="height: 100%;">
    <el-col :span="16">
      <el-carousel height="200px" direction="vertical">
        <el-carousel-item v-for="item in picItem" :key="item.sliId">
          <el-link :href=item.sliUrl target="_blank">
            <img :src="item.sliSrc" class="image" :alt="item.sliTitle"
                 style="object-fit: fill;width: 100%;height: 100%">
          </el-link>
        </el-carousel-item>
      </el-carousel>
    </el-col>
    <el-col :span="8">
      <div style="height:100%;">
        <el-table
            max-height="200px"
            style="width: 100%;height: 100%;"
            :data="noteData"
            :default-sort = "{prop: 'ncreatetime', order: 'descending'}"
        >
          <el-table-column type="expand">
            <template #default="props">
              <el-form label-position="left" inline class="demo-table-expand1">
                <el-form-item label="内容:">
                  <span>{{ props.row.ncontent }}</span>
                </el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column
              prop="ntitle"
              label="站内通知"
              width="300"
          >
          </el-table-column>

        </el-table>
      </div>
    </el-col>
  </el-row>
</template>

<script>
import {request} from "../../../network/request";
import {ElMessage} from "element-plus";

export default {
  name: "Carousel.vue",
  data(){
    return{
      picItem: [],
      picdata:[],
      noteData:[]
    }
  },
  created() {
    this.loadData()
    this.loadNoteData()
  },
  methods:{
     loadData(){
       request({url:'/slidepic/list',method:'get'}).then(res=>{
         this.picdata = res.data.data
         for(let i in this.picdata)
         {
            if(this.picdata[i].sliIsuse===1)
            {
               this.picItem.push(this.picdata[i])
            }
         }
       }).catch(err=>{
         ElMessage.error("加载轮播图数据出现问题"+err)
       })
     },
     loadNoteData(){
       request({url:'/exnote/list',method:'get'}).then(res=>{
         this.noteData = res.data.data
       }).catch(err=>{
         ElMessage.error("加载公告数据出现问题"+err)
       })
     }
  }
}
</script>

<style>
.el-carousel__item h3 {
  color: #475669;
  font-size: 14px;
  opacity: 0.75;
  line-height: 200px;
  margin: 0;
}
.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}
.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}
.demo-table-expand1 {
  font-size: 0;
}
.demo-table-expand label{
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand1 .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 100%;
}

</style>