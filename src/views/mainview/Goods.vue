<template>
  <div>
    <carousel></carousel>
    <el-row style="height: 840px;">
      <el-tooltip effect="dark" placement="right"
                  v-for="item in goodsData
                                 .slice((currentPage-1)*pageSize,currentPage*pageSize)
                                 .filter(item =>  !Number(categoryId) || item.gcateid === Number(categoryId))
                                 .filter(item => !inputSearch || item.gname.toLowerCase().includes(inputSearch.toLowerCase()))
                                 .filter(item => item.gison===1)
                                 .filter(item => item.gownerid !==username)"
                  :key="item.gid">
        <template #content>
          <p style="font-size: 14px;margin-bottom: 6px;">{{ item.gname }}</p>
          <p style="font-size: 13px;margin-bottom: 6px">
            <span>{{ item.gownerid }}</span> |
            <span>{{ item.gupdatetime }}</span> | ¥
            <span>{{ item.gprice }}</span>
          </p>
          <p style="width: 300px">商品描述: {{ item.gdetail }}</p>
        </template>
        <el-card style="width:135px;margin-bottom: 20px;float: left;height: 210px;margin-right: 15px;"
                 bodyStyle="padding:10px" shadow="hover">
          <div>
            <el-col style="height: 190px;">
              <img v-if="item.gcover" :src="item.gcover" alt="封面">
              <img v-else src="https://i.loli.net/2019/04/10/5cada7e73d601.jpg" alt="封面">
            </el-col>
            <el-col :offset="3" style="height: 20px;line-height: 20px;">
              {{ item.gname }}
            </el-col>
          </div>
        </el-card>
      </el-tooltip>
    </el-row>
    <el-row>
      <el-col :span="8" :offset="6">
        <el-pagination
            background
            @current-change="handleCurrentChange"
            :page-size=pageSize
            :total="total"
        >
        </el-pagination>
      </el-col>

    </el-row>
  </div>
</template>

<script>
import Carousel from '../../components/content/carousel/Carousel'
import {ElMessage} from "element-plus";
import {request} from "../../network/request";

export default {
  name: "Goods",
  components: {
    Carousel
  },
  data() {
    return {
      total: 0,
      currentPage: 1,
      pageSize: 18,
      goodsData: [],
      userData: []
    }
  },
  props: {
    categoryId: '',
    inputSearch: ''
  },
  created() {
    this.getGoodsData()
    this.getUsername()
  },
  mounted() {

  },
  computed: {
    username() {
      return this.$store.state.user.uname
    }
  },
  methods: {
    handleCurrentChange(currentPage) {
      this.currentPage = currentPage;
    },
    async getGoodsData() {
      await request({url: '/goods/list', method: 'get'}).then(res => {
        this.goodsData = res.data.data.records
        this.total = res.data.data.total
      }).catch(err => {
        ElMessage.error('发生以下错误:' + err);
      })
      await request({url: '/user/list', method: 'get'}).then(res => {
        this.userData = res.data.data
      }).catch(err => {
        ElMessage.error('发生以下错误:' + err);
      })

      for (let i = 0; i < this.goodsData.length; i++) {
        this.goodsData[i].gownerid = this.userData.find(item => item.uid === this.goodsData[i].gownerid).uname
        console.log(this.goodsData[i].gownerid)
      }
    },
    getUsername() {
      console.log(1)
      console.log(2)
    }
  }

}
</script>

<style scoped>
img {
  width: 115px;
  height: 172px;
  /*margin: 0 auto;*/
}

a {
  text-decoration: none;
}

a:link, a:visited, a:focus {
  color: #3377aa;
}
</style>