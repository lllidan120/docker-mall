
<style lang="less">
    @import '../../styles/common.less';
</style>

<template>
    <div @keyup.enter="getData()">

        <Card>
            <Row>
                <Col span="4">
                关键词:
                <Input v-model="form.$key" placeholder="请输入关键字..." style="width: 150px" />
                </Col>
                <Col span="16">
                时间日期:
                <datePickerCompoent
                        :showSelect="false"
                        @startDateChange="startDateChange"
                        @endDateChange="endDateChange"
                ></datePickerCompoent>
                </Col>
            </Row>
            <Row class="margin-top-10">
                <Col span="3" style="padding-top: 6px;">
                表格样式:
                <i-switch v-model="showControl"  size="large"></i-switch>
                </Col>
                <Col span="3">
                <span style="margin: 0 10px;"><Button type="primary" icon="search" @click="getData()">搜索</Button></span>
                </Col>
            </Row>
        </Card>

        <Card class="margin-top-10">
            <initDataGridCompoent ref="dataGrid" :param="form"  :showControl="showControl" @selectRow="selectRow" @dbClickRow="dbClickRow" ></initDataGridCompoent>
        </Card>
    </div>
</template>
<!-- 第三方公司管理 -->
<script>
    import Util from '../../libs/util';
    // 头部组件
    import datePickerCompoent from '../toolbar-components/datePicker-component';

    // dataGrid组件
    import initDataGridCompoent from '../toolbar-components/initDataGrid-component';


    export default {
        name: 'ThirdPlatformCompanyManagentView',
        components: {
            datePickerCompoent,

            initDataGridCompoent
        },
        data () {
            return {
                form: {
                    $key: '',
                    $StartDate: '',
                    $EndDate: '',

                    $StartPoint: '',
                    $CarrerCompanyId: '',

                    isLoad: true, 
                    $pageRecord: 30,
                    $rowIndex : 1,
                    strMethod: 'QueryThirdPlatformCompanyList'

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
                this.form.$rowIndex = 1;
                this.$refs.dataGrid.initDataGrid()
            },
            selectRow(data) {
                this.selectRowData = data
            },
            dbClickRow(data) {
                this.selectRowData = data
            },
            startDateChange(data) {
                this.form.$StartDate = data
            },
            endDateChange(data) {
                this.form.$EndDate = data
            },
            exportAllDataChange(data){
                allexcel.tranformAll(data)
            }
        },
        mounted () {
            // 可在此从服务端获取表格数据
            this.getData()
        }
    };
</script>
