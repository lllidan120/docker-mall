<style lang="less">
    @import '../../styles/common.less';
</style>

<template>
    <div @keyup.enter="getData()">

        <Card>
            <Row>
            	<Col span="4">
                    线路:
                    <selectRoute @on-change="selectRouteChange"></selectRoute>
                </Col>
                <Col span="4">
                    仓库:
                    <selectWarhours @on-change="selectWarhoursChange"></selectWarhours>
                </Col>
                
            </Row>
            <Row class="margin-top-10"> 
                <Col span="16">
                    时间日期:
                    <datePickerCompoent
                    @typeChange="typeChange"
                    @startDateChange="startDateChange"
                    @endDateChange="endDateChange"
                    ></datePickerCompoent>
                </Col>
            </Row>
            <Row class="margin-top-10">
                <Col span="3" style="padding-top: 6px;">
                    表格样式
                    <i-switch v-model="showControl"  size="large"></i-switch>
                </Col>
                
                <Col span="3">
                    <span style="margin: 0 10px;"><Button type="primary" icon="search" @click="getData()">搜索</Button></span>
                </Col>
            </Row>
        </Card>

        <Card class="margin-top-10">
            <initDataGridCompoent ref="dataGrid" :param="form" :showControl="showControl" @selectRow="selectRow" @dbClickRow="dbClickRow"></initDataGridCompoent>
        </Card>
</div>
</template>
<!-- 快递订单列表 -->
<script>
    import Util from '../../libs/util';
    // 头部组件
    import selectWarhours from '../toolbar-components/selectWarhours-component';
    import selectRoute from '../toolbar-components/selectRoute-component';
    import selectStatu from '../toolbar-components/selectStatu-component';
    import datePickerCompoent from '../toolbar-components/datePicker-component';   

    // dataGrid组件
    import initDataGridCompoent from '../toolbar-components/initDataGrid-noPage-component';

    // 中转线组件
    // import transitDetailsComponent from './component/transitDetailsComponent'

    export default {
        name: 'TransitSummaryView',
        components: {
            datePickerCompoent,
            selectWarhours,
            selectRoute,
            selectStatu,
            // transitDetailsComponent,
            initDataGridCompoent
        },
        data () {
            return {
                form: {
                    $key: '',
                    $StartDate: '',
                    $EndDate: '',

                    isLoad: true,
                    $pageRecord: 15,
                    // $rowIndex : 1,
                    strMethod: 'QueryTransitSummaryList',

                    $WarhoursCode: '',

                    $MStartDate: '',
                    $MEndDate: ''
                },
                showControl: false,
                selectRowData: undefined,
            };
        },
        methods: {
            getData () {
                 for(var key in this.form) {
                    if(this.form[key] === ''){
                        this.form[key] = undefined;
                    }
                }
                this.$refs.dataGrid.resizePage(1,10)
                this.$refs.dataGrid.initDataGrid()
            },
            selectRow(data) {
                this.selectRowData = data
            },
            dbClickRow(data) { 
                var _this = this;
                // this.selectRowData = data
                let proData = {
                    isLoad: true,
                    $WarhoursCode : data.WarhoursCode,
                    $LinCode : this.form.LinCode,
                    $StartDate : this.form.$StartDate,
                    $EndDate : this.form.$EndDate,
                    $MStartDate : this.form.$MStartDate,
                    $MEndDate : this.form.$MEndDate,
                    $key : this.form.$key,
                    strMethod: 'QueryTransitSummaryDetailedList'
                }
                for(var key in proData) {
                    if(proData[key] === ""){
                        proData[key] = undefined;
                    }
                }
                Util.openNewPage(_this, 'dataGridNewPage' , undefined, proData);
                _this.$router.push({
                    name: 'dataGridNewPage',
                    params: proData
                });
            },
            startDateChange(data) {
                this.form.$StartDate = data
                this.form.$MStartDate = data
            },
            endDateChange(data) {
                this.form.$EndDate = data
                this.form.$MEndDate = data
            },
            selectWarhoursChange(data) {
                this.form.$WarhoursCode = data
            },
            selectStatuChange(data) {
                this.form.$Statu = data
            },
            selectThirdPlatformChange(data) {
                this.form.$ThirdPlatformId = data
            },
            selectRouteChange(data) {
                this.form.$LinCode = data
            },
            typeChange(data) {
                // 根据数值类型修改
                if(data == 0) {
                    this.form.$MStartDate = undefined
                    this.form.$MEndDate = undefined
                }
                if(data == 1) {
                    this.form.$EndDate = undefined
                    this.form.$StartDate = undefined
                }
            }
        },
        mounted () {
            // 可在此从服务端获取表格数据
            this.getData()
        }
};
</script>
