import { getListGroup } from "../service/groupService";


const handleGetListGroup = async (req, res) => {
    try {

        let data = await getListGroup();

        return res.status(200).json({
            EM: data.EM,
            EC: data.EC,
            DT: data.DT
        })

    } catch (error) {
        return res.status(500).json({
            EM: "error from server",
            EC: "-1",
            DT: ""
        })
    }
}

export {
    handleGetListGroup
}
