// NestJS
import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";

// Common
import { DeliveryStatus, OrderStatus, PaymentStatus } from '@yj-major-project/common';

// Other Dependencies
import mongoose from "mongoose";


export type OrderDocument = Order & Document;

@Schema({
    timestamps: true,
    versionKey: false,
    toJSON: {
        transform: function (doc, ret) {
            ret.id = ret._id;
            delete ret._id;
        }
    }
})
export class Order {
    @Prop({
        type: String,
        required: true,
        enum: OrderStatus,
        default: OrderStatus.Open
    })
    orderStatus: OrderStatus;

    @Prop({
        type: String,
        required: true,
        enum: PaymentStatus,
        default: PaymentStatus.Unpaid
    })
    paymentStatus: PaymentStatus;

    @Prop({
        type: String,
        required: true,
        enum: DeliveryStatus,
        default: DeliveryStatus.Queue
    })
    deliveryStatus: DeliveryStatus;

    @Prop({
        type: Date
    })
    deliveredOn: Date;

    @Prop({
        type: [Object],
        required: true
    })
    items: Object[];

    @Prop({
        type: Number,
        required: true
    })
    total: Number;

    @Prop({
        type: Object,
        required: true
    })
    shippingAddress: Object;

    @Prop({
        type: mongoose.Schema.Types.ObjectId,
        required: true
    })
    userId: mongoose.ObjectId;
}

export const OrderSchema = SchemaFactory.createForClass(Order);